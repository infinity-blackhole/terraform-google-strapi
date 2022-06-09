resource "google_storage_bucket" "upload" {
  project       = var.project
  name          = "${var.project}-${var.name}-upload"
  location      = var.multi_region
  force_destroy = true
}

resource "google_storage_bucket_iam_member" "upload_storage_admin" {
  bucket = google_storage_bucket.upload.name
  role   = "roles/storage.admin"
  member = "serviceAccount:${var.service_account}"
}
