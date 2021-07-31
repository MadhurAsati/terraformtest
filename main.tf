# Configure the Microsoft Azure Provider
provider "azurerm" {
    features {}
}

locals {
    resource_group_name = element(coalescelist(data.azurerm_resource_group.rgrp.*.name, azurerm_resource_group.rg.*.name, [""]), 0)  
    location            = element(coalescelist(data.azurerm_resource_group.rgrp.*.location, azurerm_resource_group.rg.*.location, [""]), 0) 
     subnet_name         = element(coalescelist(data.azurerm_subnet.example.*.name, azurerm_subnet.myterraformsubnet.*.name, [""]), 0) 
     subnet_id           = element(coalescelist(data.azurerm_subnet.example.*.id, azurerm_subnet.myterraformsubnet.*.id, [""]), 0)
}


data "azurerm_resource_group" "myrgrp" {
  count = var.create_resource_group == false ? 1 : 0
  name  = var.resource_group_name
}


resource "azurerm_resource_group" "myrg" {
  count    = var.create_resource_group ? 1 : 0
  name     = var.resource_group_name
  location = var.location
}

data "azurerm_subnet" "snetexample" {
        count                = var.create_vnet_subnet == false ? 1 : 0
        name                 = var.subnet_name 
        virtual_network_name = var.vnet_name 
        resource_group_name  = local.resource_group_name
}

# Create subnet
resource "azurerm_subnet" "myterraformsubnet" {    
    count                = var.create_vnet_subnet ? 1 : 0    
    name                 = var.subnet_name #"mySubnet"    
    resource_group_name  = local.resource_group_name    
    virtual_network_name = var.vnet_name    
    address_prefixes     = var.addr_prefix #["10.0.1.0/24"]
    }

    


data "azurerm_network_security_group" "example" {
    #count               = var.create_nsg == false ? 1 : 0
    name                = var.nsg_name
    resource_group_name = local.resource_group_name
}


# Create network interface
resource "azurerm_network_interface" "myterraformnic" {   
     name                      = var.nic_name    
    location                  = local.location   
     resource_group_name       = local.resource_group_name
    ip_configuration {        
    name                          = "myNicConfiguration"        
    subnet_id                     = local.subnet_id        
    private_ip_address_allocation = "Dynamic"        
    
    }
    # Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "example" {
    network_interface_id      = azurerm_network_interface.myterraformnic.id
    network_security_group_id = data.azurerm_network_security_group.example.id
}


# Create storage account for boot diagnostics

resource "azurerm_storage_account" "mystorageaccount" {
    name                        = var.sa_name   
    resource_group_name         = local.resource_group_name   
     location                    = local.location    
    account_tier                = var.sa_account_tier #"Standard"    
    account_replication_type    = var.sa_account_replication_type #"LRS"}

# Create (and display) an SSH key
resource "tls_private_key" "example_ssh" {
  algorithm = "RSA"
  rsa_bits = 4096
}
output "tls_private_key" { value = tls_private_key.example_ssh.private_key_pem }


# Create virtual machine
resource "azurerm_linux_virtual_machine" "myterraformvm" {
    name                  = var.vm_name 
    location              = local.location
    resource_group_name   = local.resource_group_name
    network_interface_ids = [azurerm_network_interface.myterraformnic.id]
    size                  = var.vm_size 
     os_disk {
        name              = var.os_disk_name 
        caching           = var.caching 
        storage_account_type = var.storage_account_type 
    }
        source_image_reference {
        publisher = var.publisher #"Canonical"
        offer     = var.offer #"UbuntuServer"
        sku       = var.sku #"18.04-LTS"
        version   = var.source_image_version #"latest"
    }
        computer_name  = var.computer_name 
    admin_username = var.admin_username 
    disable_password_authentication = var.disable_password_authentication

    admin_ssh_key {
        username       = var.username 
        public_key     = tls_private_key.example_ssh.public_key_openssh
    }

 
}
