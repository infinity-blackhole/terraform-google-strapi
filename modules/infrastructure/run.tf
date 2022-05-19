resource "google_cloud_run_service" "strapi" {
  project                    = var.project
  name                       = var.name
  location                   = var.region
  autogenerate_revision_name = true
  metadata {
    annotations = {
      "run.googleapis.com/ingress" = "internal-and-cloud-load-balancing"
    }
  }
  template {
    metadata {
      annotations = {
        "run.googleapis.com/vpc-access-connector" = google_vpc_access_connector.strapi_cloudsql.name
        "run.googleapis.com/vpc-access-egress"    = "private-ranges-only"
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
          value = google_sql_database.strapi.name
        }
        env {
          name  = "DATABASE_USER"
          value = google_sql_user.strapi.name
        }
        env {
          name = "DATABASE_PASSWORD"
          value_from {
            secret_key_ref {
              name = google_secret_manager_secret.strapi_cloudsql_password.secret_id
              key  = tonumber(element(split("/", google_secret_manager_secret_version.strapi_cloudsql_password.name), 5))
            }
          }
        }
        resources {
          limits = {
            cpu    = "1000m"
            memory = "256Mi"
          }
        }
      }
      service_account_name = google_service_account.strapi.email
    }
  }
}

resource "google_cloud_run_service_iam_member" "strapi_all_user_run_invoker" {
  project  = var.project
  service  = google_cloud_run_service.strapi.name
  location = google_cloud_run_service.strapi.location
  role     = "roles/run.invoker"
  member   = "allUsers"
}
