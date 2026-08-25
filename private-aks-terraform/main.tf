data "azurerm_resource_group" "existing" {
  name = var.resource_group_name
}

data "azurerm_virtual_network" "existing" {
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
}

data "azurerm_container_registry" "existing" {
  name                = var.acr_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "private_aks" {
  name                 = var.aks_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = data.azurerm_virtual_network.existing.name
  address_prefixes     = var.aks_subnet_prefix
}

resource "azurerm_kubernetes_cluster" "private_aks" {
  name                = var.aks_name
  location            = data.azurerm_resource_group.existing.location
  resource_group_name = data.azurerm_resource_group.existing.name

  dns_prefix         = var.dns_prefix
  kubernetes_version = var.kubernetes_version

  private_cluster_enabled             = true
  private_dns_zone_id                 = "System"
  private_cluster_public_fqdn_enabled = false

  identity {
    type = "SystemAssigned"
  }

  role_based_access_control_enabled = true
  local_account_disabled            = false

  oidc_issuer_enabled       = true
  workload_identity_enabled = true

  sku_tier = "Standard"

  automatic_upgrade_channel = "patch"

  node_resource_group = "${var.aks_name}-nrg"

  default_node_pool {
    name       = "system"
    vm_size    = var.vm_size
    node_count = var.node_count

    vnet_subnet_id = azurerm_subnet.private_aks.id

    os_disk_size_gb = 128
    type             = "VirtualMachineScaleSets"

    only_critical_addons_enabled = true

    upgrade_settings {
      max_surge = "10%"
    }

    tags = var.tags
  }

  network_profile {
    network_plugin      = "azure"
    network_plugin_mode = "overlay"
    network_policy      = "azure"

    service_cidr   = var.service_cidr
    dns_service_ip = var.dns_service_ip
    pod_cidr       = var.pod_cidr

    outbound_type = "loadBalancer"
  }

  azure_policy_enabled           = true
  http_application_routing_enabled = false

  tags = var.tags

  depends_on = [
    azurerm_subnet.private_aks
  ]
}

resource "azurerm_role_assignment" "acr_pull" {
  scope                = data.azurerm_container_registry.existing.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.private_aks.kubelet_identity[0].object_id
}
