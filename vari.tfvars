create_resource_group           = false      
resource_group_name             = "" 
location                        = "East US 2"   
create_vnet_subnet              = true         
vnet_name                       = ""   
subnet_name                     = ""   
addr_prefix                     = []
nsg_name                        = ""
nic_name                        = ""
sa_name                         = ""
sa_account_tier                 = "Standard"
sa_account_replication_type     = "LRS"
vm_name                         = "my-vm"
vm_size                         = "Standard_DS1_v2"
os_disk_name                    = "myOSDisk"
caching                         = "ReadWrite"
storage_account_type            = "Premium_LRS"
publisher                       = "Canonical"
offer                           = "UbuntuServer"
sku                             = "18.04-LTS"
source_image_version            = "latest"
