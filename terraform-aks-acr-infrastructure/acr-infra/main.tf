module "rg" {
  source         = "./modules/resource_group"
  resource_group = var.resource_group
  location       = var.location
}

module "acr" {
  source         = "./modules/acr"
  acr_name       = var.acr_name
  resource_group = var.resource_group
  location       = var.location

  depends_on = [module.rg]
}

output "acr_id" {
  value = module.acr.acr_id
}

output "acr_name" {
  value = module.acr.acr_name
}