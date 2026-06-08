
output "resource_group_name" {
  value = module.resource_group.name
}

output "vnet_name" {
  value = module.virtual_network.name
}

output "subnet_name" {
  value = module.subnet.name
}
