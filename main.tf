module "cms" {
  source                         = "./modules/cms"
  project                        = var.project
  name                           = var.name
  multi_region                   = var.multi_region
  region                         = var.region
  zone                           = var.zone
  image                          = var.cms_image
  cpu                            = var.cms_cpu
  memory                         = var.cms_memory
  max_instances                  = var.cms_max_instances
  client_name                    = var.cms_client_name
  client_version                 = var.cms_client_version
  database_tier                  = var.database_tier
  database_disk_type             = var.database_disk_type
  database_availability_type     = var.database_availability_type
  database_version               = var.database_version
  database_backup_start_time     = var.database_backup_start_time
  database_backup_retention_days = var.database_backup_retention_days
  service_account                = google_service_account.cms.email
  depends_on = [
    google_project_service.artifact_registry,
    google_project_service.run,
    google_project_service.sql_admin,
    google_project_service.vpc_access,
    google_project_service.compute,
    google_project_service.service_networking
  ]
}

module "app" {
  source          = "./modules/app"
  project         = var.project
  name            = var.name
  region          = var.region
  image           = var.app_image
  cpu             = var.app_cpu
  memory          = var.app_memory
  max_instances   = var.app_max_instances
  client_name     = var.app_client_name
  client_version  = var.app_client_version
  service_account = google_service_account.app.email
  depends_on = [
    google_project_service.artifact_registry,
    google_project_service.run
  ]
}

module "edge" {
  source      = "./modules/edge"
  project     = var.project
  name        = var.name
  region      = var.region
  brand       = var.brand
  domains     = var.domains
  app_service = module.app.service.name
  cms_service = module.cms.service.name
  depends_on = [
    google_project_service.iap,
    google_project_service.compute,
  ]
}
