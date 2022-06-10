locals {
  cloud_build_service_agent = "${data.google_project.default.number}@cloudbuild.gserviceaccount.com"
}
