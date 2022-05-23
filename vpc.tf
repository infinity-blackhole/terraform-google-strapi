
resource "google_vpc_access_connector" "strapi_cloudsql" {
  project       = var.project
  name          = var.name
  region        = var.region
  ip_cidr_range = "10.8.0.0/28"
  network       = google_compute_network.strapi_cloudsql.name
  depends_on = [
    google_project_service.vpcaccess
  ]
}
