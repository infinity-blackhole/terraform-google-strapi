resource "google_vpc_access_connector" "default" {
  project       = var.project
  name          = "${var.name}-cms"
  region        = var.region
  ip_cidr_range = "10.8.0.0/28"
  network       = var.network
}
