resource "google_cloud_run_service" "default" {
  project                    = var.project
  name                       = "${var.name}-app"
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
      metadata[0].annotations["client.knative.dev/user-image"],
      metadata[0].annotations["run.googleapis.com/client-name"],
      metadata[0].annotations["run.googleapis.com/client-version"],
      metadata[0].annotations["run.googleapis.com/ingress-status"],
      metadata[0].annotations["serving.knative.dev/creator"],
      metadata[0].annotations["serving.knative.dev/lastModifier"],
      template[0].metadata[0].annotations["client.knative.dev/user-image"],
      template[0].metadata[0].annotations["run.googleapis.com/client-name"],
      template[0].metadata[0].annotations["run.googleapis.com/client-version"],
      template[0].spec[0].containers[0].image
    ]
  }
}
