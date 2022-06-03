data "google_project" "strapi" {
  project_id = var.project
}

resource "google_iap_client" "strapi" {
  display_name = title(var.name)
  brand        = "projects/${data.google_project.strapi.number}/brands/${var.brand}"
}
