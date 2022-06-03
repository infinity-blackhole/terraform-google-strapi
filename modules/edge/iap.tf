data "google_project" "default" {
  project_id = var.project
}

resource "google_iap_client" "default" {
  display_name = title(var.name)
  brand        = "projects/${data.google_project.default.number}/brands/${var.brand}"
}
