resource "google_service_account" "strapi_app" {
  project      = var.project
  account_id   = "${var.name}-app"
  display_name = "${title(var.name)} App Service Account"
}
