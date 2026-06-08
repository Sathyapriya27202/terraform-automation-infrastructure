variable "subnets" {
  description = "List of subnets to create"
  type = list(object({
    name           = string
    address_prefix = string
  }))
}
variable "resource_group_name" {
  type = string
}
variable "vnet_name" {
  type = string
}
