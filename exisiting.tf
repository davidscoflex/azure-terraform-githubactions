data "azurerm_resource_group" "resourcegroup2" {
  name = "existing_resgrp"
}

resource "azurerm_virtual_network" "network2" {
  name                = "david_network2"
  address_space       = ["10.0.0.0/16"]
  location            = data.azurerm_resource_group.resourcegroup2.location
  resource_group_name = data.azurerm_resource_group.resourcegroup2.name
}

resource "azurerm_subnet" "subnet2" {
  name                 = "david_subnet2"
  resource_group_name  = data.azurerm_resource_group.resourcegroup2.name
  virtual_network_name = azurerm_virtual_network.network2.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "nic2" {
  name                = "david_nic2"
  location            = data.azurerm_resource_group.resourcegroup2.location
  resource_group_name = data.azurerm_resource_group.resourcegroup2.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "vm2" {
  name                            = "terraform-vm2"
  resource_group_name             = data.azurerm_resource_group.resourcegroup2.name
  location                        = data.azurerm_resource_group.resourcegroup2.location
  size                            = "Standard_F2"
  admin_username                  = "adminuser"
  admin_password                  = "Pass344%%"
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.nic2.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

resource "azurerm_storage_account" "storage2" {
  name                     = "davidstorage888"
  resource_group_name      = data.azurerm_resource_group.resourcegroup2.name
  location                 = data.azurerm_resource_group.resourcegroup2.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}