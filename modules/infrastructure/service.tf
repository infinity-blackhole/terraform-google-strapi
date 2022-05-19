resource "google_service_networking_connection" "strapi_cloudsql" {
  network                 = google_compute_network.strapi_cloudsql.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.strapi_cloudsql.name]
}
