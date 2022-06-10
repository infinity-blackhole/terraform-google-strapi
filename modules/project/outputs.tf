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

output "artifact_registry_repository" {
  value       = google_artifact_registry_repository.default_container_registry
  description = "Container registry"
}
