# # resource "azurerm_resource_group" "terraformrscgroup" {
# #   name     = "terraform-resgroup-2"
# #   location = "East US"
# # }

# resource "azurerm_storage_account" "storage" {
#   name                     = "terraformstorage6655"
#   resource_group_name      = azurerm_resource_group.terraformrscgroup.name
#   location                 = azurerm_resource_group.terraformrscgroup.location
#   account_tier             = "Standard"
#   account_replication_type = "GRS"

#   tags = {
#     environment = "terraform-stagging"
#   }
# }