resource "google_project_service" "run" {
  project                    = var.project
  service                    = "run.googleapis.com"
  disable_dependent_services = false
  disable_on_destroy         = false
}

resource "google_project_service" "sql_admin" {
  project                    = var.project
  service                    = "sqladmin.googleapis.com"
  disable_dependent_services = false
  disable_on_destroy         = false
}

resource "google_project_service" "vpc_access" {
  project                    = var.project
  service                    = "vpcaccess.googleapis.com"
  disable_dependent_services = false
  disable_on_destroy         = false
}

resource "google_project_service" "secret_manager" {
  project                    = var.project
  service                    = "secretmanager.googleapis.com"
  disable_dependent_services = false
  disable_on_destroy         = false
}

resource "google_project_service" "storage" {
  project                    = var.project
  service                    = "storage.googleapis.com"
  disable_dependent_services = false
  disable_on_destroy         = false
}
