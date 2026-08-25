output "aks_name" {
  description = "Private AKS name"
  value       = azurerm_kubernetes_cluster.private_aks.name
}

output "aks_id" {
  description = "Private AKS resource ID"
  value       = azurerm_kubernetes_cluster.private_aks.id
}

output "aks_private_fqdn" {
  description = "Private AKS API server FQDN"
  value       = azurerm_kubernetes_cluster.private_aks.private_fqdn
}

output "aks_private_subnet_id" {
  description = "Private AKS subnet ID"
  value       = azurerm_subnet.private_aks.id
}

output "acr_id" {
  description = "Existing ACR ID"
  value       = data.azurerm_container_registry.existing.id
}

output "aks_kubelet_identity" {
  description = "AKS kubelet identity object ID"
  value       = azurerm_kubernetes_cluster.private_aks.kubelet_identity[0].object_id
}
