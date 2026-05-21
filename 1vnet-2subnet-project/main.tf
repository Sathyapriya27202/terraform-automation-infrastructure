
module "resource_group" {
  source              = "./modules/resource_group"
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "virtual_network" {
  source              = "./modules/virtual_network"
  vnet_name           = var.vnet_name
  resource_group_name = module.resource_group.name
  location            = var.location
  address_space       = var.address_space
}

module "subnet" {
  source              = "./modules/subnet"
  subnet_name         = var.subnet_name
  resource_group_name = module.resource_group.name
  vnet_name           = module.virtual_network.name
  subnet_prefix       = var.subnet_prefix
}
