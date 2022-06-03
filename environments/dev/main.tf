terraform {
  backend "gcs" {
    bucket = "terraform-state-unicorn-project-dev"
  }
}

module "default" {
  source       = "../.."
  project      = "par-unicorn-dev"
  multi_region = "EU"
  region       = "europe-west1"
  zone         = "europe-west1-b"
  brand        = "202922177550"
  domains = [
    "unicorn.dev.sfeirfactory.com"
  ]
}

resource "google_project_iam_member" "default_domain_sfeir_https_resource_accessor" {
  project = "par-unicorn-dev"
  role    = "roles/iap.httpsResourceAccessor"
  member  = "domain:sfeir.com"
}
