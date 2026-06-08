variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "vpn_gateway_name" {
  type = string
}

variable "public_ip_name" {
  type = string
}

variable "sku" {
  type = string
}

variable "gateway_subnet_id" {
  type = string
}

variable "vpn_client_address_pool" {
  type = list(string)
}

variable "vpn_client_protocols" {
  type = list(string)
}

variable "vpn_auth_types" {
  type = list(string)
}

variable "root_certificates" {
  description = "List of root certificates for P2S VPN"
  type = list(object({
    name             = string
    public_cert_data = string
  }))
  default = []
}