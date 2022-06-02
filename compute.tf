resource "google_compute_network" "strapi" {
  project = var.project
  name    = var.name
  depends_on = [
    google_project_service.compute
  ]
}

resource "google_compute_global_address" "strapi" {
  project       = var.project
  name          = var.name
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.strapi.id
}
