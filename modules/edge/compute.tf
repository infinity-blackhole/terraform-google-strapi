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
}

resource "google_compute_managed_ssl_certificate" "default" {
  project = var.project
  name    = random_id.default_ssl_certificate.hex
  managed {
    domains = var.domains
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
    hosts        = var.domains
    path_matcher = "strapi"
  }
  path_matcher {
    default_service = google_compute_backend_service.front.id
    name            = "strapi"
    path_rule {
      paths   = ["/dashboard", "/dashboard/*"]
      service = google_compute_backend_service.cms.id
      route_action {
        url_rewrite {
          path_prefix_rewrite = "/"
        }
      }
    }
  }
}

resource "google_compute_backend_service" "cms" {
  project     = var.project
  name        = "${var.name}-cms"
  description = title(var.name)
  backend {
    group = google_compute_region_network_endpoint_group.cms.id
  }
  iap {
    oauth2_client_id     = google_iap_client.default.client_id
    oauth2_client_secret = google_iap_client.default.secret
  }
}

data "google_cloud_run_service" "cms" {
  project  = var.project
  location = var.region
  name     = "${var.name}-cms"
}

resource "google_compute_region_network_endpoint_group" "cms" {
  project               = var.project
  name                  = "${var.name}-cms"
  network_endpoint_type = "SERVERLESS"
  region                = var.region
  cloud_run {
    service = var.cms_service
  }
}

resource "google_compute_backend_service" "front" {
  project     = var.project
  name        = "${var.name}-front"
  description = "${title(var.name)} App"
  backend {
    group = google_compute_region_network_endpoint_group.front.id
  }
  iap {
    oauth2_client_id     = google_iap_client.default.client_id
    oauth2_client_secret = google_iap_client.default.secret
  }
}

data "google_cloud_run_service" "front" {
  project  = var.project
  location = var.region
  name     = "${var.name}-front"
}

resource "google_compute_region_network_endpoint_group" "front" {
  project               = var.project
  name                  = "${var.name}-front"
  network_endpoint_type = "SERVERLESS"
  region                = var.region
  cloud_run {
    service = var.app_service
  }
}
