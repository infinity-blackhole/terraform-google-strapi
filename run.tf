resource "google_cloud_run_service" "strapi" {
  project                    = var.project
  name                       = var.name
  location                   = var.region
  autogenerate_revision_name = true
  metadata {
    annotations = {
      "client.knative.dev/user-image"     = var.image
      "run.googleapis.com/client-name"    = "gcloud"
      "run.googleapis.com/client-version" = "381.0.0"
      "run.googleapis.com/ingress"        = "internal-and-cloud-load-balancing"
    }
  }
  template {
    metadata {
      annotations = {
        "client.knative.dev/user-image"           = var.image
        "run.googleapis.com/client-name"          = "gcloud"
        "run.googleapis.com/client-version"       = "381.0.0"
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
          name  = "DATABASE_NAME"
          value = google_sql_database.strapi.name
        }
        env {
          name  = "DATABASE_USERNAME"
          value = google_sql_user.strapi.name
        }
        env {
          name  = "DATABASE_HOST"
          value = "/cloudsql/${google_sql_database_instance.strapi.connection_name}"
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
  lifecycle {
    ignore_changes = [
      metadata[0].annotations["client.knative.dev/user-image"],
      metadata[0].annotations["run.googleapis.com/client-name"],
      metadata[0].annotations["run.googleapis.com/client-version"],
      template[0].metadata[0].annotations["client.knative.dev/user-image"],
      template[0].metadata[0].annotations["run.googleapis.com/client-name"],
      template[0].metadata[0].annotations["run.googleapis.com/client-version"],
      template[0].spec[0].containers[0].image
    ]
  }
  depends_on = [
    google_project_service.run
  ]
}

resource "google_cloud_run_service_iam_member" "strapi_all_user_run_invoker" {
  project  = var.project
  service  = google_cloud_run_service.strapi.name
  location = google_cloud_run_service.strapi.location
  role     = "roles/run.invoker"
  member   = "allUsers"
}

resource "google_project_iam_member" "strapi_strapi_cloudsql_instance_user" {
  project = var.project
  role    = "roles/cloudsql.instanceUser"
  member  = "serviceAccount:${google_service_account.strapi.email}"
  depends_on = [
    google_project_service.sqladmin
  ]
}

resource "google_project_iam_member" "strapi_strapi_cloudsql_client" {
  project = var.project
  role    = "roles/cloudsql.client"
  member  = "serviceAccount:${google_service_account.strapi.email}"
  depends_on = [
    google_project_service.sqladmin
  ]
}
