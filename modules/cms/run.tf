resource "google_cloud_run_service" "default" {
  project                    = var.project
  name                       = "${var.name}-cms"
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
        "run.googleapis.com/cloudsql-instances"   = google_sql_database_instance.default.connection_name
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
          name  = "DATABASE_PASSWORD"
          value = google_sql_user.default.password
        }
        env {
          name  = "DATABASE_HOST"
          value = "/cloudsql/${google_sql_database_instance.default.connection_name}"
        }
        env {
          name  = "UPLOAD_GCS_BUCKET_NAME"
          value = google_storage_bucket.default_upload.name
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

resource "google_cloud_run_service_iam_member" "default_all_user_run_invoker" {
  project  = var.project
  service  = google_cloud_run_service.default.name
  location = google_cloud_run_service.default.location
  role     = "roles/run.invoker"
  member   = "allUsers"
}

resource "google_project_iam_member" "default_strapi_cloudsql_instance_user" {
  project = var.project
  role    = "roles/cloudsql.instanceUser"
  member  = "serviceAccount:${var.service_account}"
}

resource "google_project_iam_member" "default_strapi_cloudsql_client" {
  project = var.project
  role    = "roles/cloudsql.client"
  member  = "serviceAccount:${var.service_account}"
}
