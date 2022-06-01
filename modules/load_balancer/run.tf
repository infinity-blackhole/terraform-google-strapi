data "google_cloud_run_service" "strapi" {
  name     = var.name
  location = var.region
}
