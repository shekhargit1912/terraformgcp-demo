resource "google_sql_database_instance" "databases" {
  for_each         = var.database_configs
  name             = "${var.environment}-${each.key}-db"
  database_version = "POSTGRES_13"
  region           = var.region

  settings {
    tier = each.value.tier
    ip_configuration {
      ipv4_enabled    = false
      private_network = var.vpc_id
    }
  }
}