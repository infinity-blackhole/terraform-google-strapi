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
        var.name,
        "--image", "${local.strapi_image_name}:$COMMIT_SHA",
        "--region", var.region,
        "--cpu", var.cpu,
        "--memory", var.memory,
        "--port", "1337",
        "--no-traffic",
        "--max-instances", var.max_instances,
        "--service-account", google_service_account.strapi.email,
        "--no-allow-unauthenticated",
        "--ingress", "internal-and-cloud-load-balancing",
        "--vpc-egress", "private-ranges-only",
        "--vpc-connector", google_vpc_access_connector.strapi.name,
        "--add-cloudsql-instances", google_sql_database_instance.strapi.connection_name,
        "--set-env-vars", "DATABASE_NAME=${google_sql_database.strapi.name}",
        "--set-env-vars", "DATABASE_USERNAME=${google_sql_user.strapi.name}",
        "--set-env-vars", "DATABASE_PASSWORD=${google_sql_user.strapi.password}",
        "--set-env-vars", "DATABASE_HOST=/cloudsql/${google_sql_database_instance.strapi.connection_name}",
        "--set-env-vars", "UPLOAD_GCS_BUCKET_NAME=${google_storage_bucket.strapi_upload.name}",
      ]
    }
  }
  depends_on = [
    google_project_service.cloudbuild
  ]
}
