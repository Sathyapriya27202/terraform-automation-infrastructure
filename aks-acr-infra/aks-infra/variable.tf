variable "resource_group_name" {
  description = "Name of the resource group where AKS will be deployed"
  type        = string
}

variable "location" {
  description = "Azure region for AKS deployment"
  type        = string
}

variable "aks_name" {
  description = "AKS cluster name"
  type        = string
}

variable "acr_id" {
  description = "Azure Container Registry ID to attach with AKS"
  type        = string
}

variable "node_count" {
  description = "AKS node count"
  type        = number
  default     = 1
}