resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = var.rg_name
  location            = var.location

  sku                 = var.sku

  admin_enabled       = false

  public_network_access_enabled = false

  network_rule_bypass_option = "AzureServices"

  tags = var.tags
}

