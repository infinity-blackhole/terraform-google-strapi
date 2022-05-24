resource "google_storage_bucket" "strapi_assets" {
  project       = var.project
  name          = "${var.project}-${var.name}-assets"
  location      = "EU"
  force_destroy = true
}

resource "google_storage_bucket_iam_member" "member" {
  bucket = google_storage_bucket.strapi_assets.name
  role   = "roles/storage.admin"
  member = "serviceAccount:${google_service_account.strapi.email}"
}
