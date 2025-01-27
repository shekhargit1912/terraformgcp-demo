resource "google_compute_instance" "app_vms" {
  for_each     = var.instances
  name         = "${var.environment}-${each.key}"
  machine_type = each.value.machine_type
  zone         = each.value.zone

  boot_disk {
    initialize_params {
      image = "Ubuntu/Ubuntu 24.04 LTS"
    }
  }

  network_interface {
    network    = var.vpc_name
    subnetwork = var.subnet_ids[each.value.subnet_key]
  }
}

resource "google_compute_instance" "jumpbox" {
  name         = "${var.environment}-jumpbox"
  machine_type = "e2-medium"
  zone         = var.jumpbox_zone
  tags         = ["jumpbox"]

  boot_disk {
    initialize_params {
      image = "Ubuntu/Ubuntu 24.04 LTS"
    }
  }

  network_interface {
    network    = var.vpc_name
    subnetwork = var.subnet_ids["chile"]
    access_config {}
  }
}

resource "google_compute_instance_group" "app_group" {
  name      = "${var.environment}-app-group"
  zone      = var.primary_zone
  instances = [for instance in google_compute_instance.app_vms : instance.id]

  named_port {
    name = "http"
    port = 80
  }
}