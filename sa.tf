resource "google_service_account" "strapi" {
  project      = var.project
  account_id   = var.name
  display_name = "Strapi Service Account"
}