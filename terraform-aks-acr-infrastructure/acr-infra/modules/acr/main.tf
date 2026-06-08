resource "random_string" "acr_suffix" {
  length  = 5
  upper   = false
  special = false
  numeric = true
}

resource "azurerm_container_registry" "acr" {

  name                = "${var.acr_name}${random_string.acr_suffix.result}"
  resource_group_name = var.resource_group
  location            = var.location
  sku                 = "Basic"
  admin_enabled       = true

}

