variable "resource_group_name" {
  description = "Resource group where AKS will be created"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "aks_name" {
  description = "AKS cluster name"
  type        = string
}

variable "acr_id" {
  description = "ACR resource ID for image pull access"
  type        = string
}

variable "node_count" {
  description = "Number of nodes in AKS"
  type        = number
  default     = 1
}