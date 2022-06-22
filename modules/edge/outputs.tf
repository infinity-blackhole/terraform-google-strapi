output "global_ipv4_address" {
  value = google_compute_global_address.default_ipv4
}

output "global_ipv6_address" {
  value = google_compute_global_address.default_ipv6
}
