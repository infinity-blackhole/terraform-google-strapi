resource "google_artifact_registry_repository" "strapi_container_registry" {
  provider      = google-beta
  project       = var.project
  location      = var.region
  repository_id = "${var.name}-container-registry"
  description   = "Strapi container registry"
  format        = "DOCKER"
  depends_on = [
    google_project_service.artifact_registry
  ]
}
