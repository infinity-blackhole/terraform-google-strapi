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
