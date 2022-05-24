resource "google_storage_bucket" "strapi_upload" {
  project       = var.project
  name          = "${var.project}-${var.name}-upload"
  location      = "EU"
  force_destroy = true
}

resource "google_storage_bucket_iam_member" "member" {
  bucket = google_storage_bucket.strapi_upload.name
  role   = "roles/storage.admin"
  member = "serviceAccount:${google_service_account.strapi.email}"
}
