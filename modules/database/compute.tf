resource "google_compute_global_address" "default" {
  project       = var.project
  name          = var.name
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = var.network
}
