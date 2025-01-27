# Cloud SQL Instances (one per country)
resource "google_sql_database_instance" "chile_db" {
  name             = "chile-db-instance"
  database_version = "POSTGRES_13"
  region           = "southamerica-west1"

  settings {
    tier = "db-f1-micro"
    ip_configuration {
      ipv4_enabled = false
      private_network = google_compute_network.vpc.id
    }
  }
}

resource "google_sql_database_instance" "peru_db" {
  name             = "peru-db-instance"
  database_version = "POSTGRES_13"
  region           = "southamerica-west1"

  settings {
    tier = "db-f1-micro"
    ip_configuration {
      ipv4_enabled = false
      private_network = google_compute_network.vpc.id
    }
  }
}

resource "google_sql_database_instance" "ecuador_db" {
  name             = "ecuador-db-instance"
  database_version = "POSTGRES_13"
  region           = "southamerica-west1"

  settings {
    tier = "db-f1-micro"
    ip_configuration {
      ipv4_enabled = false
      private_network = google_compute_network.vpc.id
    }
  }
}