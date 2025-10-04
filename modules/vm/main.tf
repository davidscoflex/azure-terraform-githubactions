# resource "azurerm_resource_group" "terraformrscgroup" {
#   name     = "terraform-resgroup-2"
#   location = "East US"
# }

# resource "azurerm_virtual_network" "network" {
#   name                = "terraform-network"
#   address_space       = ["10.0.0.0/16"]
#   location            = azurerm_resource_group.terraformrscgroup.location
#   resource_group_name = azurerm_resource_group.terraformrscgroup.name
# }

# resource "azurerm_subnet" "subnet" {
#   name                 = "terraform-subnet"
#   resource_group_name  = azurerm_resource_group.terraformrscgroup.name
#   virtual_network_name = azurerm_virtual_network.network.name
#   address_prefixes     = ["10.0.2.0/24"]
# }

# resource "azurerm_network_interface" "nic" {
#   name                = "terraform-nic"
#   location            = azurerm_resource_group.terraformrscgroup.location
#   resource_group_name = azurerm_resource_group.terraformrscgroup.name

#   ip_configuration {
#     name                          = "internal"
#     subnet_id                     = azurerm_subnet.subnet.id
#     private_ip_address_allocation = "Dynamic"
#   }
# }

# resource "azurerm_linux_virtual_machine" "vm1" {
#   name                            = "terraform-vm1"
#   resource_group_name             = azurerm_resource_group.terraformrscgroup.name
#   location                        = azurerm_resource_group.terraformrscgroup.location
#   size                            = "Standard_F2"
#   admin_username                  = "azureuser"
#   admin_password                  = "Pass344%%LaiT"
#   disable_password_authentication = false
#   network_interface_ids = [
#     azurerm_network_interface.nic.id,
#   ]

#   os_disk {
#     caching              = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#   }

#   source_image_reference {
#     publisher = "Canonical"
#     offer     = "0001-com-ubuntu-server-jammy"
#     sku       = "22_04-lts"
#     version   = "latest"
#   }
# }