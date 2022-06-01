output "database_name" {
  value = google_sql_database_instance.strapi.name
}

output "database_username" {
  value = google_sql_user.strapi.name
}

output "database_password" {
  value     = google_sql_user.strapi.password
  sensitive = true
}

output "database_connection_name" {
  value = google_sql_database_instance.strapi.connection_name
}

output "upload_bucket" {
  value = google_storage_bucket.strapi_upload.name
}

output "service_account" {
  value = google_service_account.strapi.email
}

output "vpc_connector" {
  value = google_vpc_access_connector.strapi.name
}

output "container_registry_repository" {
  value = join("/", [
    "${google_artifact_registry_repository.strapi_container_registry.location}-docker.pkg.dev",
    google_artifact_registry_repository.strapi_container_registry.project,
    google_artifact_registry_repository.strapi_container_registry.repository_id
  ])
}
