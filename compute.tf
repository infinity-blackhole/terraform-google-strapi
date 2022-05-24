resource "google_compute_url_map" "strapi" {
  project         = var.project
  name            = var.name
  default_service = google_compute_backend_service.strapi.id
}

resource "google_compute_backend_service" "strapi" {
  project = var.project
  name    = var.name
  backend {
    group = google_compute_region_network_endpoint_group.strapi.id
  }
}

resource "google_compute_region_network_endpoint_group" "strapi" {
  project               = var.project
  name                  = var.name
  network_endpoint_type = "SERVERLESS"
  region                = var.region
  cloud_run {
    service = google_cloud_run_service.strapi.name
  }
}

resource "google_compute_network" "strapi" {
  project = var.project
  name    = var.name
}

resource "google_compute_global_address" "strapi" {
  project       = var.project
  name          = var.name
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.strapi.id
}
