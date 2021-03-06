data "google_project" "default" {
  project_id = var.project
}

resource "google_project_service" "cloudbuild" {
  project                    = var.project
  service                    = "cloudbuild.googleapis.com"
  disable_dependent_services = false
  disable_on_destroy         = true
}

resource "google_project_service" "artifact_registry" {
  project                    = var.project
  service                    = "artifactregistry.googleapis.com"
  disable_dependent_services = false
  disable_on_destroy         = true
}

resource "google_project_service" "run" {
  project                    = var.project
  service                    = "run.googleapis.com"
  disable_dependent_services = false
  disable_on_destroy         = true
}

resource "google_project_service" "sql_admin" {
  project                    = var.project
  service                    = "sqladmin.googleapis.com"
  disable_dependent_services = false
  disable_on_destroy         = true
}

resource "google_project_service" "vpc_access" {
  project                    = var.project
  service                    = "vpcaccess.googleapis.com"
  disable_dependent_services = false
  disable_on_destroy         = true
  depends_on = [
    google_project_service.compute
  ]
}

resource "google_project_service" "compute" {
  project                    = var.project
  service                    = "compute.googleapis.com"
  disable_dependent_services = false
  disable_on_destroy         = true
}

resource "google_project_service" "service_networking" {
  project                    = var.project
  service                    = "servicenetworking.googleapis.com"
  disable_dependent_services = false
  disable_on_destroy         = true
}

resource "google_project_service" "secret_manager" {
  project                    = var.project
  service                    = "secretmanager.googleapis.com"
  disable_dependent_services = false
  disable_on_destroy         = true
}
