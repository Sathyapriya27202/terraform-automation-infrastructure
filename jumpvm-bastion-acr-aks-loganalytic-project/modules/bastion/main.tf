resource "azurerm_public_ip" "bastion_ip" {

  name                = var.pip_name

  location            = var.location

  resource_group_name = var.rg_name

  allocation_method   = "Static"

  sku                 = "Standard"

  tags = var.tags
}

resource "azurerm_bastion_host" "bastion" {

  name                = var.bastion_name

  location            = var.location

  resource_group_name = var.rg_name

  ip_configuration {

    name                 = "bastion-config"

    subnet_id            = var.subnet_id

    public_ip_address_id = azurerm_public_ip.bastion_ip.id
  }

  tags = var.tags
}