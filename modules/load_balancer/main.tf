resource "google_compute_global_address" "default" {
  name = "${var.environment}-lb-ip"
}

resource "google_compute_health_check" "default" {
  name = "${var.environment}-health-check"

  http_health_check {
    port = 80
  }
}

resource "google_compute_backend_service" "default" {
  name                  = "${var.environment}-backend"
  protocol              = "HTTP"
  port_name             = "http"
  load_balancing_scheme = "EXTERNAL"
  timeout_sec           = 10
  health_checks        = [google_compute_health_check.default.id]

  backend {
    group = var.instance_group_id
  }
}

resource "google_compute_url_map" "default" {
  name            = "${var.environment}-url-map"
  default_service = google_compute_backend_service.default.id
}

resource "google_compute_target_http_proxy" "default" {
  name    = "${var.environment}-http-proxy"
  url_map = google_compute_url_map.default.id
}

resource "google_compute_global_forwarding_rule" "default" {
  name                  = "${var.environment}-lb-rule"
  ip_protocol          = "TCP"
  load_balancing_scheme = "EXTERNAL"
  port_range           = "80"
  target               = google_compute_target_http_proxy.default.id
  ip_address           = google_compute_global_address.default.id
}