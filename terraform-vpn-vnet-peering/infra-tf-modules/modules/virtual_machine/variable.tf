variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "vm_name" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "vm_size" {
  type    = string
  default = "Standard_B2s"
}


variable "admin_ssh_key" {
  description = "Admin SSH key configuration"
  type = object({
    username   = string
    public_key = string
  })
}




