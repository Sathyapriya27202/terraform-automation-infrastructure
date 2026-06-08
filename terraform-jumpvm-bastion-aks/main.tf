# Locals

locals {
  name_prefix = "${var.project_name}-${var.environment}"
}

# Resource Group

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location

  tags = var.tags
}

# Log Analytics

module "log_analytics" {
  source = "git::https://dev.azure.com/DevopsProject/_git/tf-modules?path=//modules/log-analytics?ref=main"

  rg_name       = azurerm_resource_group.rg.name
  location      = var.location
  workspace_name = "${local.name_prefix}-law"
}

# Network

module "network" {
  source = "git::https://dev.azure.com/DevopsProject/_git/tf-modules?path=//modules/network?ref=main"

  rg_name  = azurerm_resource_group.rg.name
  location = var.location

  vnet_name             = var.vnet_name
  address_space         = var.address_space

  aks_subnet_name       = var.aks_subnet_name
  aks_subnet_prefix     = var.aks_subnet_prefix

  vm_subnet_name        = var.vm_subnet_name
  vm_subnet_prefix      = var.vm_subnet_prefix

  bastion_subnet_prefix = var.bastion_subnet_prefix

  tags = var.tags
}

# Azure Container Registry

module "acr" {
  source = "git::https://dev.azure.com/DevopsProject/_git/tf-modules?path=//modules/acr?ref=main"

  rg_name  = azurerm_resource_group.rg.name
  location = var.location

  acr_name = var.acr_name
  sku      = var.acr_sku

  tags = var.tags
}

# AKS Cluster

module "aks" {
  source = "git::https://dev.azure.com/DevopsProject/_git/tf-modules?path=//modules/aks?ref=main"

  aks_name                = var.aks_name
  location                = var.location
  rg_name                 = azurerm_resource_group.rg.name

  dns_prefix              = var.dns_prefix
  kubernetes_version      = var.kubernetes_version

  private_cluster_enabled = var.private_cluster_enabled

  node_count              = var.node_count
  vm_size                 = var.vm_size

  enable_auto_scaling     = var.enable_auto_scaling
  min_count               = var.min_count
  max_count               = var.max_count

  dns_service_ip          = var.dns_service_ip
  service_cidr            = var.service_cidr
  pod_cidr                = var.pod_cidr

  subnet_id               = module.network.aks_subnet_id

  acr_id                  = module.acr.acr_id

  log_analytics_workspace_id = module.log_analytics.workspace_id

  tags = var.tags

  depends_on = [
    module.network,
    module.acr
  ]
}

# Kubernetes Namespaces

module "namespaces" {
  source = "git::https://dev.azure.com/DevopsProject/_git/tf-modules?path=//modules/namespaces?ref=main"

  namespaces = var.namespaces

  depends_on = [
    module.aks
  ]
}

# Jump VM

module "jump_vm" {
  source = "git::https://dev.azure.com/DevopsProject/_git/tf-modules?path=//modules/jump-vm?ref=main"

  rg_name       = azurerm_resource_group.rg.name
  location      = var.location

  vm_name       = var.vm_name
  vm_size       = var.vm_size_jumpbox

  subnet_id     = module.network.vm_subnet_id

  admin_username = var.admin_username
  ssh_public_key = var.ssh_public_key

  tags = var.tags

  depends_on = [
    module.network
  ]
}

# Azure Bastion

module "bastion" {
  source = "git::https://dev.azure.com/DevopsProject/_git/tf-modules?path=//modules/bastion?ref=main"

  rg_name      = azurerm_resource_group.rg.name
  location     = var.location

  subnet_id    = module.network.bastion_subnet_id

  pip_name     = var.pip_name
  bastion_name = var.bastion_name

  tags = var.tags

  depends_on = [
    module.network
  ]
}