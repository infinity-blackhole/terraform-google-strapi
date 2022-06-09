resource "random_id" "default_cloudsql" {
  byte_length = 4
  prefix      = "${var.name}-"
  keepers = {
    project                        = var.project
    region                         = var.region
    database_version               = var.database_version
    database_tier                  = var.database_tier
    database_disk_type             = var.database_disk_type
    database_availability_type     = var.database_availability_type
    zone                           = var.zone
    database_backup_start_time     = var.database_backup_start_time
    region                         = var.region
    database_backup_retention_days = var.database_backup_retention_days
  }
}

resource "google_sql_database_instance" "default" {
  project             = var.project
  name                = random_id.default_cloudsql.hex
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
      private_network = var.network
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
}
