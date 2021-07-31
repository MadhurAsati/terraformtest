variable "create_resource_group" {
    description = "Whether to create resource group and use it for all networking resources"
    default     = false
}
variable "resource_group_name" {
    description = "A container that holds related resources for an Azure solution"
}

variable "location" {
    description = "The location/region to keep all your network resources. To get the list of all locations with table format from azure cli, run 'az account list-locations -o table'"
}
variable "create_vnet_subnet" {
    description = "Whether to create a subnet in which the VM will exist"
    default     = false
}

variable "vnet_name" {
    description = "Name of your Azure Virtual Network"
}
variable "subnet_name" {
    description = "Name of the subnet in which your VM exists"
}
variable "addr_prefix" {
    description = "The address prefix to use for the subnet"
}
variable "nsg_name" {
    description = "Name of the Network Security Group which will be attached to the VM"
}
variable "nic_name" {
    description = "Name of the Network Interface which will be attached to the VM"
}
variable "sa_name" {
    description = "Name of the storage account"
}
variable "vm_size" {
    description = "Size of the VM"
}
variable "os_disk_name" {
    description = "Name of the OS disk attached to the VM"
}
variable "caching" {
    description = "The caching requirements for the Data Disk."
    default = "ReadWrite"
}
variable "storage_account_type" {
    description = "Type of storage account"
}
variable "publisher" {
    description = "The publisher of the image"
}
variable "offer" {
    description = "The offer of the image used to create the virtual machine"
}
variable "sku" {
    description = "The SKU of the image used to create the virtual machine"
}
variable "source_image_version" {
    description = "The version of the image used to create the virtual machine"
}
variable "computer_name" {
    description = "The name of the Virtual Machine"
}
variable "admin_username" {
    description = "The name of the local administrator account"
}
variable "disable_password_authentication" {
    description = "Whether password authentication should be disabled"
    default = true
}
variable "username" {
    description = "Username for the Admin SSH key"
}

