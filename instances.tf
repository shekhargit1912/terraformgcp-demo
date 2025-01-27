# Application VMs
resource "google_compute_instance" "app_vm_1" {
  name         = "app-vm-1"
  machine_type = "e2-medium"
  zone         = "southamerica-west1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network    = google_compute_network.vpc.name
    subnetwork = google_compute_subnetwork.chile_subnet.name
  }
}

resource "google_compute_instance" "app_vm_2" {
  name         = "app-vm-2"
  machine_type = "e2-medium"
  zone         = "southamerica-west1-b"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network    = google_compute_network.vpc.name
    subnetwork = google_compute_subnetwork.peru_subnet.name
  }
}

# Instance Group
resource "google_compute_instance_group" "app_group" {
  name      = "app-instance-group"
  zone      = "southamerica-west1-a"
  instances = [
    google_compute_instance.app_vm_1.id,
    google_compute_instance.app_vm_2.id
  ]

  named_port {
    name = "http"
    port = 80
  }
}