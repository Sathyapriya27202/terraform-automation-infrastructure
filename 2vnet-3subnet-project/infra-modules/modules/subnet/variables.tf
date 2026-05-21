variable "subnets" {
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
