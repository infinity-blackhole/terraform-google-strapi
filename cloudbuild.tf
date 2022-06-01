resource "google_cloudbuild_trigger" "strapi_cd" {
  project = "${var.project}/locations/${var.region}"
  name    = "strapi-cd"
  build {
    images = [
      "${local.strapi_image_name}:$COMMIT_SHA"
    ]
    step {
      name = "gcr.io/cloud-builders/docker:20.10.14"
      args = ["build", "-t", local.strapi_image_name, "."]
    }
    step {
      name = "gcr.io/cloud-builders/docker:20.10.14"
      args = ["push", local.strapi_image_name, "."]
    }
    step {
      name       = "gcr.io/google.com/cloudsdktool/cloud-sdk:387.0.0"
      entrypoint = "gcloud"
      args = [
        "run",
        "deploy",
        "strapi",
        "--image",
        "${local.strapi_image_name}:$COMMIT_SHA",
        "--region",
        var.region
      ]
    }
  }
  depends_on = [
    google_project_service.cloudbuild
  ]
}
