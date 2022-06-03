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

module "edge" {
  source  = "../../modules/edge"
  project = "par-unicorn-dev"
  region  = "europe-west1"
  domains = [
    "unicorn.sfeir.shikanime.studio"
  ]
}
