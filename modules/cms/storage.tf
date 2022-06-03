resource "google_storage_bucket" "default_upload" {
  project       = var.project
  name          = "${var.project}-${var.name}-cms-upload"
  location      = "EU"
  force_destroy = true
}

resource "google_storage_bucket_iam_member" "member" {
  bucket = google_storage_bucket.default_upload.name
  role   = "roles/storage.admin"
  member = "serviceAccount:${var.service_account}"
}