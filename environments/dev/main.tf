terraform {
  backend "gcs" {
    bucket = "terraform-state-unicorn-project-dev"
  }
}

module "project" {
  source  = "../../modules/project"
  project = var.project
  name    = var.name
  region  = var.region
}

module "deploy" {
  source                       = "../../modules/deploy"
  for_each                     = var.services
  project                      = var.project
  name                         = each.value.name
  region                       = var.region
  repository                   = each.value.repository
  display_name                 = each.value.display_name
  artifact_registry_repository = module.project.artifact_registry_repository.repository_id
}

module "delivery" {
  source       = "../../modules/delivery"
  for_each     = var.services
  project      = var.project
  name         = each.value.name
  region       = var.region
  repository   = each.value.repository
  display_name = each.value.display_name
  tag          = "^([0-9]+)\\.([0-9]+)\\.([0-9]+)-(alpha(?:\\.[0-9A-Za-z-]+)*)(?:\\+[0-9A-Za-z-]+)?$"
}

module "database" {
  source  = "../../modules/database"
  project = var.project
  name    = var.name
  region  = var.region
  zone    = var.zone
  network = module.project.network.id
}

module "cms" {
  source                   = "../../modules/cms"
  project                  = var.project
  name                     = var.services.cms.name
  multi_region             = var.multi_region
  region                   = var.region
  database_instance        = module.database.instance.name
  database_connection_name = module.database.instance.connection_name
  service_account          = module.project.service_accounts.cms.email
  network                  = module.project.network.name
}

module "front" {
  source          = "../../modules/front"
  project         = var.project
  name            = var.services.front.name
  region          = var.region
  service_account = module.project.service_accounts.front.email
}

module "edge" {
  source  = "../../modules/edge"
  project = var.project
  name    = var.name
  region  = var.region
  domains = var.domains
  services = {
    front = module.front.service.name
    cms   = module.cms.service.name
  }
}
