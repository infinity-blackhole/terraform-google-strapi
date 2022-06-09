resource "google_secret_manager_secret" "default_cloudsql_password" {
  project   = var.project
  secret_id = "${var.name}-cloudsql-password"
  replication {
    user_managed {
      replicas {
        location = var.region
      }
    }
  }
}

resource "google_secret_manager_secret_version" "default_cloudsql_password_version" {
  secret      = google_secret_manager_secret.default_cloudsql_password.id
  secret_data = google_sql_user.default.password
}
