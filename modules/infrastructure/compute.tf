resource "google_compute_url_map" "strapi" {
  project         = var.project
  name            = "strapi"
  default_service = google_compute_backend_service.strapi.id
}

resource "google_compute_backend_service" "strapi" {
  project = var.project
  name    = "strapi"
  backend {
    group = google_compute_region_network_endpoint_group.strapi.id
  }
}

resource "google_compute_region_network_endpoint_group" "strapi" {
  project               = var.project
  provider              = google
  name                  = "strapi"
  network_endpoint_type = "SERVERLESS"
  region                = var.region
  cloud_run {
    service = google_cloud_run_service.strapi.name
  }
}
