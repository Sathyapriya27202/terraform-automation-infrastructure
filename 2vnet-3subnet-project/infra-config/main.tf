module "resource_group" {
  source              = "../infra-modules/modules/resource_group"
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "virtual_network" {
  source = "../infra-modules/modules/virtual_network"

  for_each = { for v in var.vnets : v.name => v }

  vnet_name           = each.value.name
  resource_group_name = module.resource_group.name
  location            = var.location
  address_space       = each.value.address_space
}

module "subnet" {
  source = "../infra-modules/modules/subnet"

  for_each = { for v in var.vnets : v.name => v }

  resource_group_name = module.resource_group.name
  vnet_name           = module.virtual_network[each.key].name

  subnets = each.value.subnets

  depends_on = [module.virtual_network]
}
