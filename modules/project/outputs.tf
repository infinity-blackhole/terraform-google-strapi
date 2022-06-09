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
