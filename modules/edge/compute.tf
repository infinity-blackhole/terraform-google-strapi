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

resource "random_id" "strapi_ssl_certificate" {
  byte_length = 4
  prefix      = "${var.name}-"
}

resource "google_compute_managed_ssl_certificate" "strapi" {
  project = var.project
  name    = random_id.strapi_ssl_certificate.hex
  managed {
    domains = var.domains
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_url_map" "strapi" {
  project         = var.project
  name            = var.name
  default_service = google_compute_backend_service.app.id
  host_rule {
    hosts        = var.domains
    path_matcher = "strapi"
  }
  path_matcher {
    default_service = google_compute_backend_service.app.id
    name            = "strapi"
    path_rule {
      paths   = ["/dashboard"]
      service = google_compute_backend_service.strapi.id
    }
  }
}

resource "google_compute_backend_service" "strapi" {
  project     = var.project
  name        = var.name
  description = title(var.name)
  backend {
    group = google_compute_region_network_endpoint_group.strapi.id
  }
  iap {
    oauth2_client_id     = google_iap_client.strapi.client_id
    oauth2_client_secret = google_iap_client.strapi.secret
  }
}

data "google_cloud_run_service" "strapi" {
  project  = var.project
  location = var.region
  name     = var.name
}

resource "google_compute_region_network_endpoint_group" "strapi" {
  project               = var.project
  name                  = var.name
  network_endpoint_type = "SERVERLESS"
  region                = var.region
  cloud_run {
    service = data.google_cloud_run_service.strapi.name
  }
}

resource "google_compute_backend_service" "app" {
  project     = var.project
  name        = "${var.name}-app"
  description = title(var.name)
  backend {
    group = google_compute_region_network_endpoint_group.app.id
  }
  iap {
    oauth2_client_id     = google_iap_client.strapi.client_id
    oauth2_client_secret = google_iap_client.strapi.secret
  }
}

data "google_cloud_run_service" "app" {
  project  = var.project
  location = var.region
  name     = "${var.name}-app"
}

resource "google_compute_region_network_endpoint_group" "app" {
  project               = var.project
  name                  = "${var.name}-app"
  network_endpoint_type = "SERVERLESS"
  region                = var.region
  cloud_run {
    service = data.google_cloud_run_service.app.name
  }
}
