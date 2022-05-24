resource "google_sql_database_instance" "strapi" {
  project             = var.project
  name                = var.name
  region              = var.region
  database_version    = "POSTGRES_14"
  deletion_protection = false
  settings {
    tier              = var.cloudsql_tier
    disk_autoresize   = true
    disk_type         = "PD_SSD"
    availability_type = var.cloudsql_availability_type
    location_preference {
      zone = var.zone
    }
    ip_configuration {
      private_network = google_compute_network.strapi_cloudsql.id
    }
    backup_configuration {
      enabled    = true
      start_time = "01:00" # at 1AM UTC
      location   = var.region

      backup_retention_settings {
        retained_backups = 180 # 6 months
      }
    }
  }
  lifecycle {
    ignore_changes = [
      settings[0].disk_size
    ]
  }
  depends_on = [google_service_networking_connection.strapi_cloudsql]
}

resource "google_sql_database" "strapi" {
  project  = var.project
  name     = var.name
  instance = google_sql_database_instance.strapi.name
}

resource "google_sql_user" "strapi" {
  project  = var.project
  name     = google_service_account.strapi.account_id
  instance = google_sql_database_instance.strapi.name
  type     = "CLOUD_IAM_SERVICE_ACCOUNT"
}
