# Resource Group

output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

# AKS

output "aks_name" {
  value = module.aks.aks_name
}

output "aks_id" {
  value = module.aks.aks_id
}

# ACR

output "acr_login_server" {
  value = module.acr.login_server
}

output "acr_id" {
  value = module.acr.acr_id
}

# Jump VM

output "jump_vm_private_ip" {
  value = module.jump_vm.private_ip
}

# Bastion

output "bastion_public_ip" {
  value = module.bastion.bastion_public_ip
}

# Networking

output "vnet_id" {
  value = module.network.vnet_id
}