resource "random_id" "strapi_cloudsql" {
  byte_length = 4
  prefix      = "${var.name}-"
}

resource "google_sql_database_instance" "strapi" {
  project             = var.project
  name                = random_id.strapi_cloudsql.hex
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
      private_network = google_compute_network.strapi.id
    }
    backup_configuration {
      enabled    = true
      start_time = "01:00" # at 1AM UTC
      location   = var.region

      backup_retention_settings {
        retained_backups = 180 # 6 months
      }
    }
    database_flags {
      name  = "cloudsql.iam_authentication"
      value = "on"
    }
  }
  lifecycle {
    ignore_changes = [
      settings[0].disk_size
    ]
  }
  depends_on = [google_service_networking_connection.strapi]
}

resource "google_sql_database" "strapi" {
  project  = var.project
  name     = var.name
  instance = google_sql_database_instance.strapi.name
}

resource "google_sql_user" "strapi" {
  project  = var.project
  name     = local.stripe_cloud_sql_username
  instance = google_sql_database_instance.strapi.name
  type     = "CLOUD_IAM_SERVICE_ACCOUNT"
}
