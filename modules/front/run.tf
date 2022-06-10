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
        "client.knative.dev/user-image"     = var.image
        "run.googleapis.com/client-name"    = var.client_name
        "run.googleapis.com/client-version" = var.client_version
        "autoscaling.knative.dev/maxScale"  = var.max_instances
      }
    }
    spec {
      containers {
        image = var.image
        ports {
          container_port = 3000
        }
        env {
          name  = "API_CARDS"
          value = var.graphql_url
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
      template[0].spec[0].containers[0].env,
      template[0].spec[0].containers[0].resources[0].limits.cpu,
      template[0].spec[0].containers[0].resources[0].limits.memory,
    ]
  }
}

resource "google_cloud_run_service_iam_member" "default_all_user_run_invoker" {
  project  = var.project
  service  = google_cloud_run_service.default.name
  location = google_cloud_run_service.default.location
  role     = "roles/run.invoker"
  member   = "allUsers"
}
