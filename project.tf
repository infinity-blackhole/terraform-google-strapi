resource "google_project_service" "run" {
  project                    = var.project
  service                    = "run.googleapis.com"
  disable_dependent_services = false
  disable_on_destroy         = true
}

resource "google_project_service" "sqladmin" {
  project                    = var.project
  service                    = "sqladmin.googleapis.com"
  disable_dependent_services = false
  disable_on_destroy         = true
}
