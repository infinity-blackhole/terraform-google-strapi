resource "google_artifact_registry_repository" "default_container_registry" {
  provider      = google-beta
  project       = var.project
  location      = var.region
  repository_id = "${var.name}-container-registry"
  description   = "${title(var.name)} container registry"
  format        = "DOCKER"
}
