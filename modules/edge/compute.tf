resource "google_compute_global_address" "strapi_ipv4" {
  project    = var.project
  name       = "${var.name}-ipv4"
  ip_version = "IPV4"
}

resource "google_compute_global_forwarding_rule" "strapi_ipv4_http" {
  project    = var.project
  name       = "${var.name}-ipv4-http"
  target     = google_compute_target_http_proxy.strapi_http.self_link
  ip_address = google_compute_global_address.strapi_ipv4.address
  port_range = "80"
}

resource "google_compute_global_forwarding_rule" "strapi_ipv4_https" {
  project    = var.project
  name       = "${var.name}-ipv4-https"
  target     = google_compute_target_https_proxy.strapi_https.self_link
  ip_address = google_compute_global_address.strapi_ipv4.address
  port_range = "443"
}

resource "google_compute_global_address" "strapi_ipv6" {
  project    = var.project
  name       = "${var.name}-ipv6"
  ip_version = "IPV6"
}

resource "google_compute_global_forwarding_rule" "strapi_ipv6_http" {
  project    = var.project
  name       = "${var.name}-ipv6-http"
  target     = google_compute_target_http_proxy.strapi_http.self_link
  ip_address = google_compute_global_address.strapi_ipv6.address
  port_range = "80"
}

resource "google_compute_global_forwarding_rule" "strapi_ipv6_https" {
  project    = var.project
  name       = "${var.name}-ipv6-https"
  target     = google_compute_target_https_proxy.strapi_https.self_link
  ip_address = google_compute_global_address.strapi_ipv6.address
  port_range = "443"
}

resource "google_compute_target_http_proxy" "strapi_http" {
  project = var.project
  name    = "${var.name}-http"
  url_map = google_compute_url_map.strapi.name
}

resource "google_compute_target_https_proxy" "strapi_https" {
  project          = var.project
  name             = "${var.name}-https"
  ssl_certificates = [google_compute_managed_ssl_certificate.strapi.id]
  url_map          = google_compute_url_map.strapi.name
}

resource "google_compute_managed_ssl_certificate" "strapi" {
  project = var.project
  name    = var.name

  managed {
    domains = var.domains
  }
}

resource "google_compute_url_map" "strapi" {
  project         = var.project
  name            = var.name
  default_service = google_compute_backend_service.strapi.id
}

resource "google_compute_backend_service" "strapi" {
  project = var.project
  name    = var.name
  backend {
    group = google_compute_region_network_endpoint_group.strapi.id
  }
}

resource "google_compute_region_network_endpoint_group" "strapi" {
  project               = var.project
  name                  = var.name
  network_endpoint_type = "SERVERLESS"
  region                = var.region
  cloud_run {
    service = var.name
  }
}
