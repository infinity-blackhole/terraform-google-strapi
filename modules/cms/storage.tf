resource "google_storage_bucket" "upload" {
  project                     = var.project
  name                        = "${var.project}-${var.name}-upload"
  location                    = var.multi_region
  force_destroy               = true
  uniform_bucket_level_access = true
  depends_on = [
    google_project_service.storage
  ]
}

resource "google_storage_bucket_iam_member" "upload_storage_object_creator" {
  bucket = google_storage_bucket.upload.name
  role   = "roles/storage.objectCreator"
  member = "serviceAccount:${var.service_account}"
}


resource "google_storage_bucket_iam_member" "upload_storage_object_viewer" {
  bucket = google_storage_bucket.upload.name
  role   = "roles/storage.objectViewer"
  member = "serviceAccount:${var.service_account}"
}
