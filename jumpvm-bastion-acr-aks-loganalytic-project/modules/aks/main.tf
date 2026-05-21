resource "azurerm_kubernetes_cluster" "aks" {

  name                = var.aks_name
  location            = var.location
  resource_group_name = var.rg_name

  dns_prefix          = var.dns_prefix

  kubernetes_version  = var.kubernetes_version

  private_cluster_enabled = var.private_cluster_enabled

  oidc_issuer_enabled       = true
  workload_identity_enabled = true

  role_based_access_control_enabled = true

  local_account_disabled = false

  sku_tier = "Standard"

  automatic_upgrade_channel = "patch"

  node_resource_group = "${var.aks_name}-nrg"

  default_node_pool {

    name                 = "system"

    vm_size              = var.vm_size

    vnet_subnet_id       = var.subnet_id

    auto_scaling_enabled = var.enable_auto_scaling

    node_count           = var.node_count

    min_count            = var.min_count

    max_count            = var.max_count

    os_disk_size_gb      = 128

    type                 = "VirtualMachineScaleSets"

    only_critical_addons_enabled = true

    zones = length(var.availability_zones) > 0 ? var.availability_zones : null

    temporary_name_for_rotation = "rotate"

    upgrade_settings {
      max_surge = "10%"
    }

    tags = var.tags
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {

    network_plugin      = "azure"

    network_plugin_mode = "overlay"

    network_policy      = "azure"

    service_cidr        = var.service_cidr

    dns_service_ip      = var.dns_service_ip

    pod_cidr            = var.pod_cidr

    outbound_type       = "loadBalancer"
  }

  oms_agent {
    log_analytics_workspace_id = var.log_analytics_workspace_id
  }

  azure_policy_enabled = true

  http_application_routing_enabled = false

  tags = var.tags
}

############################################
# ACR Pull Role
############################################

resource "azurerm_role_assignment" "acr_pull" {

  scope                = var.acr_id

  role_definition_name = "AcrPull"

  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}