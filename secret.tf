resource "google_secret_manager_secret" "strapi_cloudsql_password" {
  project   = var.project
  secret_id = "strapi_cloudsql_password"

  replication {
    user_managed {
      replicas {
        location = var.region
      }
    }
  }
}

resource "google_secret_manager_secret_version" "strapi_cloudsql_password_version" {
  secret      = google_secret_manager_secret.strapi_cloudsql_password.id
  secret_data = google_sql_user.strapi.password
}
