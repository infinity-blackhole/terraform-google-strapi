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
    spec {
      containers {
        image = var.image
        ports {
          container_port = var.port
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

    metadata {
      annotations = {
        "autoscaling.knative.dev/maxScale" = var.max_instances
      }
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
