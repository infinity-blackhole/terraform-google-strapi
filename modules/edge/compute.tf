resource "google_compute_global_address" "default_ipv4" {
  project    = var.project
  name       = "${var.name}-ipv4"
  ip_version = "IPV4"
}

resource "google_compute_global_forwarding_rule" "default_ipv4_http" {
  project    = var.project
  name       = "${var.name}-ipv4-http"
  target     = google_compute_target_http_proxy.default_http.self_link
  ip_address = google_compute_global_address.default_ipv4.address
  port_range = "80"
}

resource "google_compute_global_forwarding_rule" "default_ipv4_https" {
  project    = var.project
  name       = "${var.name}-ipv4-https"
  target     = google_compute_target_https_proxy.default_https.self_link
  ip_address = google_compute_global_address.default_ipv4.address
  port_range = "443"
}

resource "google_compute_global_address" "default_ipv6" {
  project    = var.project
  name       = "${var.name}-ipv6"
  ip_version = "IPV6"
}

resource "google_compute_global_forwarding_rule" "default_ipv6_http" {
  project    = var.project
  name       = "${var.name}-ipv6-http"
  target     = google_compute_target_http_proxy.default_http.self_link
  ip_address = google_compute_global_address.default_ipv6.address
  port_range = "80"
}

resource "google_compute_global_forwarding_rule" "default_ipv6_https" {
  project    = var.project
  name       = "${var.name}-ipv6-https"
  target     = google_compute_target_https_proxy.default_https.self_link
  ip_address = google_compute_global_address.default_ipv6.address
  port_range = "443"
}

resource "google_compute_target_http_proxy" "default_http" {
  project = var.project
  name    = "${var.name}-http"
  url_map = google_compute_url_map.default.name
}

resource "google_compute_target_https_proxy" "default_https" {
  project          = var.project
  name             = "${var.name}-https"
  ssl_certificates = [google_compute_managed_ssl_certificate.default.id]
  url_map          = google_compute_url_map.default.name
}

resource "random_id" "default_ssl_certificate" {
  byte_length = 4
  prefix      = "${var.name}-"
  keepers = {
    project = var.project
    domains = jsonencode(var.domains)
  }
}

resource "google_compute_managed_ssl_certificate" "default" {
  project = var.project
  name    = random_id.default_ssl_certificate.hex
  managed {
    domains = toset(flatten(values(var.domains)))
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_url_map" "default" {
  project         = var.project
  name            = var.name
  default_service = google_compute_backend_service.front.id
  host_rule {
    hosts        = var.domains.cms
    path_matcher = "cms"
  }
  path_matcher {
    default_service = google_compute_backend_service.cms.id
    name            = "cms"
  }
}

resource "google_compute_backend_service" "cms" {
  project     = var.project
  name        = var.services.cms
  description = title(var.name)
  backend {
    group = google_compute_region_network_endpoint_group.cms.id
  }
}

resource "google_compute_region_network_endpoint_group" "cms" {
  project               = var.project
  name                  = var.services.cms
  network_endpoint_type = "SERVERLESS"
  region                = var.region
  cloud_run {
    service = var.services.cms
  }
}

resource "google_compute_backend_service" "front" {
  project     = var.project
  name        = var.services.front
  description = "${title(var.name)} App"
  backend {
    group = google_compute_region_network_endpoint_group.front.id
  }
}

resource "google_compute_region_network_endpoint_group" "front" {
  project               = var.project
  name                  = var.services.front
  network_endpoint_type = "SERVERLESS"
  region                = var.region
  cloud_run {
    service = var.services.front
  }
}
