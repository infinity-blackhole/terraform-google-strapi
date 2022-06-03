terraform {
  backend "gcs" {
    bucket = "terraform-state-unicorn-project-dev"
  }
}

module "strapi" {
  source       = "../../"
  project      = "par-unicorn-dev"
  multi_region = "EU"
  region       = "europe-west1"
  zone         = "europe-west1-b"
}

module "app" {
  source  = "../../modules/app"
  project = "par-unicorn-dev"
  region  = "europe-west1"
  depends_on = [
    module.strapi
  ]
}

module "edge" {
  source  = "../../modules/edge"
  project = "par-unicorn-dev"
  region  = "europe-west1"
  brand   = "202922177550"
  domains = [
    "unicorn.dev.sfeirfactory.com"
  ]
  depends_on = [
    module.strapi,
    module.app
  ]
}

resource "google_project_iam_member" "strapi_domain_sfeir_https_resource_accessor" {
  project = "par-unicorn-dev"
  role    = "roles/iap.httpsResourceAccessor"
  member  = "domain:sfeir.com"
}
