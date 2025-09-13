resource "azurerm_resource_group" "davidrsc" {
  name     = "my_resgrp"
  location = "East US"
}

resource "azurerm_virtual_network" "network" {
  name                = "davidrsc-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.davidrsc.location
  resource_group_name = azurerm_resource_group.davidrsc.name
}

resource "azurerm_subnet" "davidsub" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.davidrsc.name
  virtual_network_name = azurerm_virtual_network.network.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "davidnic" {
  name                = "davidrsc-nic"
  location            = azurerm_resource_group.davidrsc.location
  resource_group_name = azurerm_resource_group.davidrsc.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.davidsub.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "davidvm" {
  name                            = "terraform-vm"
  resource_group_name             = azurerm_resource_group.davidrsc.name
  location                        = azurerm_resource_group.davidrsc.location
  size                            = "Standard_F2"
  admin_username                  = "adminuser"
  admin_password                  = "davidrscPass344"
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.davidnic.id,
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