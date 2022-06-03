module "cms" {
  source                   = "./modules/cms"
  project                  = var.project
  name                     = var.name
  multi_region             = var.multi_region
  region                   = var.region
  zone                     = var.zone
  database_instance        = google_sql_database_instance.default.name
  database_connection_name = google_sql_database_instance.default.connection_name
  service_account          = google_service_account.cms.email
  network                  = google_compute_network.default.name
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
