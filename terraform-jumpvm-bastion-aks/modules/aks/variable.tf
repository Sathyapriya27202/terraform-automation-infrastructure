variable "rg_name" {
  type = string
}

variable "location" {
  type = string
}

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

variable "availability_zones" {
  type    = list(string)
  default = []
}

variable "node_count" {
  type = number
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

variable "subnet_id" {
  type = string
}

variable "acr_id" {
  type = string
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

variable "log_analytics_workspace_id" {
  type = string
}

variable "tags" {
  type = map(string)
}