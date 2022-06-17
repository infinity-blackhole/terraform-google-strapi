resource "google_cloudbuild_trigger" "default" {
  project     = "${var.project}/locations/${var.region}"
  name        = "${var.name}-delivery"
  description = "Delivery ${var.display_name}"
  trigger_template {
    repo_name = var.repository
    tag_name  = var.tag
  }
  build {
    step {
      args = [
        "run",
        "services",
        "update-traffic",
        "--to-revisions",
        "$_K_SERVICE-$SHORT_SHA=${var.percentage}",
        "--region",
        "$LOCATION",
        "$_K_SERVICE"
      ]
      name = "gcr.io/cloud-builders/gcloud"
    }
  }
  substitutions = {
    _K_SERVICE = var.name
  }
  depends_on = [
    google_project_service.cloudbuild
  ]
}
