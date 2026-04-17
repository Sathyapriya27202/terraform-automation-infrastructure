variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "East US"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "subnet_name" {
  description = "Name of the subnet"
  type        = string
}

variable "address_space" {
  description = "Address space for VNet"
  type        = list(string)
}

variable "subnet_prefix" {
  description = "Subnet address prefix"
  type        = string
}
