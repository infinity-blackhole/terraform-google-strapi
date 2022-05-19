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
        "run.googleapis.com/cloudsql-instances"   = google_sql_database_instance.strapi.connection_name
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
          name = "DATABASE_HOST"
          value = join(":", [
            google_sql_database_instance.strapi.project,
            google_sql_database_instance.strapi.region,
            google_sql_database_instance.strapi.name,
          ])
        }
        env {
          name  = "DATABASE_NAME"
          value = google_sql_database.strapi.name
        }
        env {
          name  = "DATABASE_USER"
          value = google_sql_user.strapi.name
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

resource "google_cloud_run_service_iam_member" "strapi_strapi_cloudsql_instance_user" {
  project  = var.project
  service  = google_cloud_run_service.strapi.name
  location = google_cloud_run_service.strapi.location
  role     = "roles/cloudsql.instanceUser"
  member   = google_service_account.strapi.email
}
