resource "google_sql_database" "default" {
  project  = var.project
  name     = "${var.name}-cms"
  instance = var.database_instance
}

resource "random_password" "default_cloudsql" {
  length  = 80
  lower   = true
  upper   = true
  number  = true
  special = false
}

resource "google_sql_user" "default" {
  project  = var.project
  name     = trimsuffix(var.service_account, ".gserviceaccount.com")
  instance = var.database_instance
  password = random_password.default_cloudsql.result
}
