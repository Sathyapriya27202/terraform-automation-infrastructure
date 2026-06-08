resource "azurerm_public_ip" "this" {
  name                = var.public_ip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_virtual_network_gateway" "this" {
  name                = var.vpn_gateway_name
  location            = var.location
  resource_group_name = var.resource_group_name

  type     = "Vpn"
  vpn_type = "RouteBased"
  sku      = var.sku

  ip_configuration {
    name                          = "gateway-ipconfig"
    subnet_id                     = var.gateway_subnet_id
    public_ip_address_id          = azurerm_public_ip.this.id
    private_ip_address_allocation = "Dynamic"
  }

  vpn_client_configuration {
    address_space        = var.vpn_client_address_pool
    vpn_client_protocols = var.vpn_client_protocols
    vpn_auth_types       = var.vpn_auth_types

    dynamic "root_certificate" {
      for_each = var.root_certificates
      content {
        name             = root_certificate.value.name
        public_cert_data = root_certificate.value.public_cert_data
      }
    }
  }
}