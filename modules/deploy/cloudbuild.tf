resource "google_cloudbuild_trigger" "deploy" {
  project     = var.project
  name        = "${var.name}-deploy"
  description = "Deploy ${var.display_name}"
  trigger_template {
    repo_name   = var.repository
    branch_name = var.branch
  }
  build {
    images = [
      "$_REGISTRY/$_K_SERVICE"
    ]
    step {
      args = [
        "build",
        "-t",
        "$_REGISTRY/$_K_SERVICE:$SHORT_SHA",
        "."
      ]
      name = "gcr.io/cloud-builders/docker"
    }
    step {
      args = [
        "push",
        "$_REGISTRY/$_K_SERVICE:$SHORT_SHA"
      ]
      name = "gcr.io/cloud-builders/docker"
    }
    step {
      args = [
        "run",
        "deploy",
        "--image",
        "$_REGISTRY/$_K_SERVICE:$SHORT_SHA",
        "--revision-suffix",
        "$SHORT_SHA",
        "--region",
        "$_K_LOCATION",
        "--no-traffic",
        "$_K_SERVICE"
      ]
      name = "gcr.io/cloud-builders/gcloud"
    }
  }
  substitutions = {
    _REGISTRY = join("/", [
      "${var.region}-docker.pkg.dev",
      var.project,
      var.artifact_registry_repository
    ])
    _K_LOCATION = var.region
    _K_SERVICE  = var.name
  }
  depends_on = [
    google_project_service.cloudbuild
  ]
}
