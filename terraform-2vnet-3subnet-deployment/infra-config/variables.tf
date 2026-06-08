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
