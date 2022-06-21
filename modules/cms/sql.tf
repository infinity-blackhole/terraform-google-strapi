resource "google_sql_database" "default" {
  project  = var.project
  name     = var.name
  instance = var.database_instance
  depends_on = [
    google_project_service.sql_admin
  ]
}

resource "random_password" "default_cloudsql" {
  length  = 32
  special = false
}

resource "google_sql_user" "default" {
  project  = var.project
  name     = trimsuffix(var.service_account, ".gserviceaccount.com")
  instance = var.database_instance
  password = random_password.default_cloudsql.result
  depends_on = [
    google_project_service.sql_admin
  ]
}
