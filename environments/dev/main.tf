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
  name                     = var.name
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
  name            = var.name
  region          = var.region
  service_account = module.project.service_accounts.front.email
}

module "edge" {
  source      = "../../modules/edge"
  project     = var.project
  name        = var.name
  region      = var.region
  brand       = var.brand
  domains     = var.domains
  app_service = module.front.service.name
  cms_service = module.cms.service.name
}

resource "google_project_iam_member" "default_domain_sfeir_https_resource_accessor" {
  project = var.project
  role    = "roles/iap.httpsResourceAccessor"
  member  = "domain:sfeir.com"
}
