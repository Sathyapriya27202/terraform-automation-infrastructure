
output "resource_group_name" {
  value = module.resource_group.name
}

output "vnet_name" {
  value = module.virtual_network.name
}

output "subnet_names" {
  value = module.subnet.subnet_name
}

