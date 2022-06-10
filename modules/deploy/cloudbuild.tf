resource "google_cloudbuild_trigger" "deploy" {
  project     = "${var.project}/locations/${var.region}"
  name        = "${var.name}-deploy"
  description = "Deploy ${var.display_name}"
  trigger_template {
    repo_name   = var.repository
    branch_name = var.branch
  }
  filename = var.filename
  substitutions = {
    _REGISTRY = join("/", [
      "${var.region}-docker.pkg.dev",
      var.project,
      var.artifact_registry_repository
    ])
    _K_SERVICE = var.name
  }
}
