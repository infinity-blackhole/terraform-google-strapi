output "service_accounts" {
  value = {
    cms   = google_service_account.cms
    front = google_service_account.front
  }
  description = "Service accounts"
}

output "network" {
  value       = google_compute_network.default
  description = "Network"
}

output "container_registry" {
  value = join("/", [
    "${google_artifact_registry_repository.default_container_registry.location}-docker.pkg.dev",
    google_artifact_registry_repository.default_container_registry.project,
    google_artifact_registry_repository.default_container_registry.repository_id
  ])
}
