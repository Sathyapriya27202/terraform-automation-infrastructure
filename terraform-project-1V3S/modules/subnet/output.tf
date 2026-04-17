output "subnet_name" {
  value = [for s in azurerm_subnet.subnet : s.name]
}

output "subnet_ids" {
  value = { for k, s in azurerm_subnet.subnet : k => s.id }
}
