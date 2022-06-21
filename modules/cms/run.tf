resource "google_cloud_run_service" "default" {
  project                    = var.project
  name                       = var.name
  location                   = var.region
  autogenerate_revision_name = true
  metadata {
    annotations = {
      "client.knative.dev/user-image"     = var.image
      "run.googleapis.com/client-name"    = var.client_name
      "run.googleapis.com/client-version" = var.client_version
      "run.googleapis.com/ingress"        = "internal-and-cloud-load-balancing"
    }
  }
  template {
    metadata {
      annotations = {
        "client.knative.dev/user-image"           = var.image
        "run.googleapis.com/client-name"          = var.client_name
        "run.googleapis.com/client-version"       = var.client_version
        "run.googleapis.com/vpc-access-connector" = google_vpc_access_connector.default.name
        "run.googleapis.com/vpc-access-egress"    = "private-ranges-only"
        "run.googleapis.com/cloudsql-instances"   = var.database_connection_name
        "autoscaling.knative.dev/maxScale"        = var.max_instances
      }
    }
    spec {
      containers {
        image = var.image
        ports {
          container_port = 1337
        }
        env {
          name  = "DATABASE_NAME"
          value = google_sql_database.default.name
        }
        env {
          name  = "DATABASE_USERNAME"
          value = google_sql_user.default.name
        }
        env {
          name = "DATABASE_PASSWORD"
          value_from {
            secret_key_ref {
              name = google_secret_manager_secret.default_cloudsql_password.secret_id
              key  = "latest"
            }
          }
        }
        env {
          name  = "DATABASE_HOST"
          value = "/cloudsql/${var.database_connection_name}"
        }
        env {
          name  = "UPLOAD_STORAGE_NAME"
          value = google_storage_bucket.upload.name
        }
        env {
          name = "JWT_SECRET"
          value_from {
            secret_key_ref {
              name = google_secret_manager_secret.jwt_secret.secret_id
              key  = "latest"
            }
          }
        }
        env {
          name = "APP_KEYS"
          value_from {
            secret_key_ref {
              name = google_secret_manager_secret.app_keys.secret_id
              key  = "latest"
            }
          }
        }
        env {
          name = "API_TOKEN_SALT"
          value_from {
            secret_key_ref {
              name = google_secret_manager_secret.api_token_salt.secret_id
              key  = "latest"
            }
          }
        }
        env {
          name = "ADMIN_JWT_SECRET"
          value_from {
            secret_key_ref {
              name = google_secret_manager_secret.admin_jwt_secret.secret_id
              key  = "latest"
            }
          }
        }
        env {
          name  = "HOST"
          value = "0.0.0.0"
        }
        resources {
          limits = {
            cpu    = var.cpu
            memory = var.memory
          }
        }
      }
      service_account_name = var.service_account
    }
  }
  lifecycle {
    ignore_changes = [
      metadata[0].annotations,
      template[0].metadata[0].annotations,
      template[0].spec[0].containers[0].image,
      template[0].spec[0].containers[0].resources[0].limits.cpu,
      template[0].spec[0].containers[0].resources[0].limits.memory,
    ]
  }
  depends_on = [
    google_project_service.run,
    google_secret_manager_secret_version.default_cloudsql_password,
    google_secret_manager_secret_version.jwt_secret,
    google_secret_manager_secret_version.app_keys,
    google_secret_manager_secret_version.api_token_salt,
    google_secret_manager_secret_version.admin_jwt_secret
  ]
}

resource "google_cloud_run_service_iam_member" "default_all_user_run_invoker" {
  project  = var.project
  service  = google_cloud_run_service.default.name
  location = google_cloud_run_service.default.location
  role     = "roles/run.invoker"
  member   = "allUsers"
}
