resource "random_id" "strapi_cloudsql" {
  byte_length = 4
  prefix      = "${var.name}-"
}

resource "google_sql_database_instance" "strapi" {
  project             = var.project
  name                = random_id.strapi_cloudsql.hex
  region              = var.region
  database_version    = var.database_version
  deletion_protection = false
  settings {
    tier              = var.database_tier
    disk_autoresize   = true
    disk_type         = var.database_disk_type
    availability_type = var.database_availability_type
    location_preference {
      zone = var.zone
    }
    ip_configuration {
      private_network = google_compute_network.strapi.id
    }
    backup_configuration {
      enabled    = true
      start_time = var.database_backup_start_time
      location   = var.region

      backup_retention_settings {
        retained_backups = var.database_backup_retention_days
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
  depends_on = [
    google_service_networking_connection.strapi
  ]
}

resource "google_sql_database" "strapi" {
  project  = var.project
  name     = var.name
  instance = google_sql_database_instance.strapi.name
}

resource "random_password" "strapi_cloudsql" {
  length  = 80
  lower   = true
  upper   = true
  number  = true
  special = false
}

resource "google_sql_user" "strapi" {
  project  = var.project
  name     = google_service_account.strapi.account_id
  instance = google_sql_database_instance.strapi.name
  password = random_password.strapi_cloudsql.result
}
