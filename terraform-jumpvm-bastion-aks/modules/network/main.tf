# Virtual Network

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.rg_name

  address_space       = var.address_space

  tags = var.tags
}

# AKS Subnet

resource "azurerm_subnet" "aks" {
  name                 = var.aks_subnet_name
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name

  address_prefixes     = var.aks_subnet_prefix

  service_endpoints = [
    "Microsoft.Storage",
    "Microsoft.ContainerRegistry",
    "Microsoft.KeyVault"
  ]
}

# Jump VM Subnet

resource "azurerm_subnet" "vm" {
  name                 = var.vm_subnet_name
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name

  address_prefixes     = var.vm_subnet_prefix
}

# Bastion Subnet

resource "azurerm_subnet" "bastion" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name

  address_prefixes     = var.bastion_subnet_prefix
}

# NSG - AKS

resource "azurerm_network_security_group" "aks_nsg" {
  name                = "${var.vnet_name}-aks-nsg"
  location            = var.location
  resource_group_name = var.rg_name

  tags = var.tags
}

resource "azurerm_subnet_network_security_group_association" "aks" {
  subnet_id                 = azurerm_subnet.aks.id
  network_security_group_id = azurerm_network_security_group.aks_nsg.id
}

# NSG - Jump VM

resource "azurerm_network_security_group" "vm_nsg" {
  name                = "${var.vnet_name}-vm-nsg"
  location            = var.location
  resource_group_name = var.rg_name

  security_rule {
    name                       = "AllowSSHFromBastion"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = var.tags
}

resource "azurerm_subnet_network_security_group_association" "vm" {
  subnet_id                 = azurerm_subnet.vm.id
  network_security_group_id = azurerm_network_security_group.vm_nsg.id
}

 #Route Table

resource "azurerm_route_table" "aks_rt" {
  name                = "${var.vnet_name}-aks-rt"
  location            = var.location
  resource_group_name = var.rg_name

  tags = var.tags
}

resource "azurerm_subnet_route_table_association" "aks" {
  subnet_id      = azurerm_subnet.aks.id
  route_table_id = azurerm_route_table.aks_rt.id
}