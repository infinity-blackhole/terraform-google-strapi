terraform {
  backend "gcs" {
    bucket = "terraform-state-unicorn-project-dev"
  }
}

module "base" {
  source  = "../../modules/base"
  project = "par-unicorn-dev"
}

module "cms" {
  source          = "../../modules/cms"
  project         = "par-unicorn-dev"
  multi_region    = "EU"
  region          = "europe-west1"
  zone            = "europe-west1-b"
  service_account = module.base.cms_service_account.email
  depends_on = [
    module.base
  ]
}

module "app" {
  source          = "../../modules/app"
  project         = "par-unicorn-dev"
  region          = "europe-west1"
  service_account = module.base.app_service_account.email
  depends_on = [
    module.base
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
    module.base,
    module.cms,
    module.app
  ]
}

resource "google_project_iam_member" "default_domain_sfeir_https_resource_accessor" {
  project = "par-unicorn-dev"
  role    = "roles/iap.httpsResourceAccessor"
  member  = "domain:sfeir.com"
}
