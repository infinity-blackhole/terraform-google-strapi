resource "google_cloudbuild_trigger" "strapi" {
  project = "${var.project}/locations/${var.region}"
  name    = var.name
  github {
    owner = "infinity-blackhole"
    name  = "null"
    push {
      branch = "main"
    }
  }
  build {
    images = [
      local.strapi_container_image
    ]
    step {
      name = var.docker_container_image
      args = [
        "build",
        "-t",
        local.strapi_container_image,
        "."
      ]
    }
  }
  depends_on = [
    google_project_service.cloudbuild
  ]
}
