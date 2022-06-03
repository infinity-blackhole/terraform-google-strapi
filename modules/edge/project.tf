resource "google_project_service" "iap" {
  project                    = var.project
  service                    = "iap.googleapis.com"
  disable_dependent_services = false
  disable_on_destroy         = true
}
