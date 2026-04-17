variable "location" {
  description = "Azure region where resources will be created"
  type        = string
}

variable "resource_group" {
  description = "Resource group for ACR"
  type        = string
}

variable "acr_name" {
  description = "Container registry name"
  type        = string
}

