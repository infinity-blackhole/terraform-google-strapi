resource "google_cloudbuild_trigger" "default" {
  project     = "${var.project}/locations/${var.region}"
  name        = "${var.name}-delivery"
  description = "Delivery ${var.display_name}"
  trigger_template {
    repo_name = var.repository
    tag_name  = var.tag
  }
  filename = var.filename
  substitutions = {
    _K_SERVICE = var.name
  }
}
