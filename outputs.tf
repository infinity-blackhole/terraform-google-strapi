output "cms_service_account" {
  value = google_service_account.cms
}

output "app_service_account" {
  value = google_service_account.front
}
