locals {
  strapi_image_name = join("/", [
    "${google_artifact_registry_repository.strapi_container_registry.location}-docker.pkg.dev",
    google_artifact_registry_repository.strapi_container_registry.project,
    google_artifact_registry_repository.strapi_container_registry.repository_id
  ])
}
