# Global Load Balancer Configuration
resource "google_compute_global_address" "default" {
  name = "global-lb-ip"
}

# Health Check
resource "google_compute_health_check" "default" {
  name = "http-health-check"

  http_health_check {
    port = 80
  }
}

# Backend Service
resource "google_compute_backend_service" "default" {
  name                  = "backend-service"
  protocol              = "HTTP"
  port_name             = "http"
  load_balancing_scheme = "EXTERNAL"
  timeout_sec           = 10
  health_checks        = [google_compute_health_check.default.id]

  backend {
    group = google_compute_instance_group.app_group.id
  }
}

# URL Map
resource "google_compute_url_map" "default" {
  name            = "url-map"
  default_service = google_compute_backend_service.default.id
}

# HTTP Proxy
resource "google_compute_target_http_proxy" "default" {
  name    = "http-proxy"
  url_map = google_compute_url_map.default.id
}

# Global Forwarding Rule
resource "google_compute_global_forwarding_rule" "default" {
  name                  = "global-rule"
  ip_protocol          = "TCP"
  load_balancing_scheme = "EXTERNAL"
  port_range           = "80"
  target               = google_compute_target_http_proxy.default.id
  ip_address           = google_compute_global_address.default.id
}