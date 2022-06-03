resource "google_compute_network" "default" {
  project = var.project
  name    = "${var.name}-cms"
}

resource "google_compute_global_address" "default" {
  project       = var.project
  name          = "${var.name}-cms"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.default.id
}
