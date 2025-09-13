terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.43.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "d8cbb305-0e4c-4ea6-a06a-1178f1139c70"
}