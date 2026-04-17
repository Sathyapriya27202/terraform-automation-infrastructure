variable "location" {
  description = "Azure region for resources"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "vnets" {
  description = "List of VNets with their subnets"
  type = list(object({
    name          = string
    address_space = list(string)
    subnets       = list(object({
      name           = string
      address_prefix = string
    }))
  }))
}

variable "vpn_gateway" {
  description = "VPN Gateway configuration"
  type = object({
    vpn_gateway_name        = string
    public_ip_name          = string
    sku                     = string
    vpn_client_address_pool = list(string)
    vpn_client_protocols    = list(string)
    vpn_auth_types          = list(string)
    root_cert_name          = string
  })
}

variable "virtual_machine" {
  description = "Virtual machine configuration"
  type = object({
    name = string
    size = string
  })
}

