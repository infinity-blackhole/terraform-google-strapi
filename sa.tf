resource "google_service_account" "cms" {
  project      = var.project
  account_id   = "${var.name}-cms"
  display_name = "${title(var.name)} CMS Service Account"
}

resource "google_service_account" "app" {
  project      = var.project
  account_id   = "${var.name}-app"
  display_name = "${title(var.name)} App Service Account"
}
