resource "google_artifact_registry_repository" "strapi_container_registry" {
  provider      = google-beta
  project       = var.region
  location      = var.region
  repository_id = "${var.name}-containers"
  description   = "Container Registry for Strapi"
  format        = "DOCKER"
  depends_on = [
    google_project_service.artifact_registry
  ]
}
