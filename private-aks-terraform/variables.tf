variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "resource_group_name" {
  description = "Existing Resource Group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "vnet_name" {
  description = "Existing VNet name"
  type        = string
}

variable "aks_subnet_name" {
  description = "New subnet for private AKS"
  type        = string
}

variable "aks_subnet_prefix" {
  description = "CIDR for new AKS subnet"
  type        = list(string)
}

variable "acr_name" {
  description = "Existing Azure Container Registry"
  type        = string
}

variable "aks_name" {
  description = "New private AKS cluster name"
  type        = string
}

variable "dns_prefix" {
  description = "AKS DNS prefix"
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes version"
  type        = string
}

variable "node_count" {
  description = "Number of system nodes"
  type        = number
}

variable "vm_size" {
  description = "AKS node VM size"
  type        = string
}

variable "service_cidr" {
  description = "Kubernetes service CIDR"
  type        = string
}

variable "dns_service_ip" {
  description = "Kubernetes DNS service IP"
  type        = string
}

variable "pod_cidr" {
  description = "Kubernetes pod CIDR"
  type        = string
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
}
