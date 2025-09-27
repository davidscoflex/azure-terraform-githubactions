terraform {
  backend "azurerm" {
    resource_group_name  = "test_rsgroup"
    storage_account_name = "backendstorage1288"
    container_name       = "backend-container"
    key                  = "terraform.tfstate"
  }
}