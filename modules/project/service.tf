resource "google_service_networking_connection" "default" {
  network = google_compute_network.default.id
  service = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [
    google_compute_global_address.default.name
  ]
  depends_on = [
    google_project_service.service_networking
  ]
}
