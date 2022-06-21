resource "google_project_iam_member" "cms_cloudsql_instance_user" {
  project = var.project
  role    = "roles/cloudsql.instanceUser"
  member  = "serviceAccount:${google_service_account.cms.email}"
}

resource "google_project_iam_member" "cms_cloudsql_client" {
  project = var.project
  role    = "roles/cloudsql.client"
  member  = "serviceAccount:${google_service_account.cms.email}"
}

resource "google_project_iam_member" "cms_secret_accessor" {
  project = var.project
  role    = "roles/secretmanager.secretAccessor"
  member  = "serviceAccount:${google_service_account.cms.email}"
}

resource "google_project_iam_member" "cloudbuild_run_developer" {
  project = var.project
  role    = "roles/run.developer"
  member  = "serviceAccount:${local.cloud_build_service_agent}"
}

#tfsec:ignore:google-iam-no-project-level-service-account-impersonation
resource "google_project_iam_member" "cloudbuild_iam_service_account_user" {
  project = var.project
  role    = "roles/iam.serviceAccountUser"
  member  = "serviceAccount:${local.cloud_build_service_agent}"
}

resource "google_project_iam_member" "cloudbuild_secret_accessor" {
  project = var.project
  role    = "roles/secretmanager.secretAccessor"
  member  = "serviceAccount:${local.cloud_build_service_agent}"
}
