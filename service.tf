resource "google_service_networking_connection" "strapi" {
  network = google_compute_network.strapi.id
  service = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [
    google_compute_global_address.strapi.name
  ]
  depends_on = [
    google_project_service.service_networking
  ]
}
