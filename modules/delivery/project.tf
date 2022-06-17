resource "google_project_service" "cloudbuild" {
  project                    = var.project
  service                    = "cloudbuild.googleapis.com"
  disable_dependent_services = false
  disable_on_destroy         = false
}
