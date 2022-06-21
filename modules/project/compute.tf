resource "google_compute_network" "default" {
  project = var.project
  name    = var.name
  depends_on = [
    google_project_service.compute
  ]
}
