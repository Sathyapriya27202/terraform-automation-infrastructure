module "resource_group" {
  source              = "../aa-az-iaas-tf-modules/modules/resource_group"
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "virtual_network" {
  source              = "../aa-az-iaas-tf-modules/modules/virtual_network"
  for_each            = { for v in var.vnets : v.name => v }
  vnet_name           = each.value.name
  resource_group_name = module.resource_group.name
  location            = var.location
  address_space       = each.value.address_space
}

module "subnet" {
  source              = "../aa-az-iaas-tf-modules/modules/subnet"
  for_each            = { for v in var.vnets : v.name => v }
  resource_group_name = module.resource_group.name
  vnet_name           = module.virtual_network[each.key].name
  subnets             = each.value.subnets
}

module "vpn_gateway" {
  source = "../aa-az-iaas-tf-modules/modules/vpn_gateway"

  resource_group_name = module.resource_group.name
  location            = var.location

  vpn_gateway_name = var.vpn_gateway.vpn_gateway_name
  public_ip_name   = var.vpn_gateway.public_ip_name
  sku              = var.vpn_gateway.sku

  gateway_subnet_id = module.subnet["hub-vnet"].subnet_ids["GatewaySubnet"]

  vpn_client_address_pool = var.vpn_gateway.vpn_client_address_pool
  vpn_client_protocols    = var.vpn_gateway.vpn_client_protocols
  vpn_auth_types          = var.vpn_gateway.vpn_auth_types

  root_certificates = [
    {
      name             = var.vpn_gateway.root_cert_name
      public_cert_data = filebase64("${path.module}/certs/MyRootCert.cer")
    }
  ]
}

module "vnet_peering" {
  source              = "../aa-az-iaas-tf-modules/modules/vnet_peering"
  resource_group_name = module.resource_group.name

  hub_vnet_name = module.virtual_network["hub-vnet"].name
  hub_vnet_id   = module.virtual_network["hub-vnet"].id

  spoke_vnet_name = module.virtual_network["spoke-vnet"].name
  spoke_vnet_id   = module.virtual_network["spoke-vnet"].id

  depends_on = [
    module.vpn_gateway
  ]
}

module "virtual_machine" {
  source = "../aa-az-iaas-tf-modules/modules/virtual_machine"

  resource_group_name = module.resource_group.name
  location            = var.location

  vm_name = var.virtual_machine.name
  vm_size = var.virtual_machine.size

  subnet_id = module.subnet["spoke-vnet"].subnet_ids["spoke-app-subnet"]

  admin_ssh_key = {
    username   = "azureuser"
    public_key = file("${path.root}/keys/azure-vpn-test-rsa.pub")
  }

  depends_on = [
    module.vnet_peering
  ]
}





