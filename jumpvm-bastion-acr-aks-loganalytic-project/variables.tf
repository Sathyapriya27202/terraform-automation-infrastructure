# Global

variable "subscription_id" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "environment" {
  type = string
}

variable "project_name" {
  type = string
}

# Tags

variable "tags" {
  type = map(string)
}

# Networking

variable "vnet_name" {
  type = string
}

variable "address_space" {
  type = list(string)
}

variable "aks_subnet_name" {
  type = string
}

variable "aks_subnet_prefix" {
  type = list(string)
}

variable "vm_subnet_name" {
  type = string
}

variable "vm_subnet_prefix" {
  type = list(string)
}

variable "bastion_subnet_prefix" {
  type = list(string)
}

# ACR

variable "acr_name" {
  type = string
}

variable "acr_sku" {
  type = string
}

# AKS

variable "aks_name" {
  type = string
}

variable "dns_prefix" {
  type = string
}

variable "kubernetes_version" {
  type = string
}

variable "private_cluster_enabled" {
  type = bool
}

variable "node_count" {
  type = number
}

variable "availability_zones" {
  type = list(string)
}

variable "vm_size" {
  type = string
}

variable "enable_auto_scaling" {
  type = bool
}

variable "min_count" {
  type = number
}

variable "max_count" {
  type = number
}

variable "service_cidr" {
  type = string
}

variable "dns_service_ip" {
  type = string
}

variable "pod_cidr" {
  type = string
}

# Jump VM

variable "vm_name" {
  type = string
}

variable "vm_size_jumpbox" {
  type = string
}

variable "admin_username" {
  type = string
}

variable "ssh_public_key" {
  type      = string
  sensitive = true
}

# Bastion

variable "bastion_name" {
  type = string
}

variable "pip_name" {
  type = string
}

# Namespaces

variable "namespaces" {
  type = list(string)
}