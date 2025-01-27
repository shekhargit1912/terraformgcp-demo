terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = "southamerica-west1"  # Santiago, Chile
}

# VPC Network
resource "google_compute_network" "vpc" {
  name                    = "latam-vpc"
  auto_create_subnetworks = false
}

# Subnets (one per country)
resource "google_compute_subnetwork" "chile_subnet" {
  name          = "chile-subnet"
  ip_cidr_range = "10.1.0.0/24"
  network       = google_compute_network.vpc.id
  region        = "southamerica-west1"
}

resource "google_compute_subnetwork" "peru_subnet" {
  name          = "peru-subnet"
  ip_cidr_range = "10.2.0.0/24"
  network       = google_compute_network.vpc.id
  region        = "southamerica-west1"
}

resource "google_compute_subnetwork" "ecuador_subnet" {
  name          = "ecuador-subnet"
  ip_cidr_range = "10.3.0.0/24"
  network       = google_compute_network.vpc.id
  region        = "southamerica-west1"
}

# Firewall Rules
resource "google_compute_firewall" "allow_internal" {
  name    = "allow-internal"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }
  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }
  allow {
    protocol = "icmp"
  }

  source_ranges = ["10.0.0.0/8"]
}

resource "google_compute_firewall" "allow_rdp" {
  name    = "allow-rdp"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["jumpbox"]
}

# Jumpbox Instance
resource "google_compute_instance" "jumpbox" {
  name         = "jumpbox"
  machine_type = "e2-medium"
  zone         = "southamerica-west1-a"

  tags = ["jumpbox"]

  boot_disk {
    initialize_params {
      image = "windows-cloud/windows-2019"
    }
  }

  network_interface {
    network    = google_compute_network.vpc.name
    subnetwork = google_compute_subnetwork.chile_subnet.name
    access_config {
      # This empty block assigns a public IP
    }
  }
}