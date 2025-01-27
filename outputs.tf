output "jumpbox_public_ip" {
  value = google_compute_instance.jumpbox.network_interface[0].access_config[0].nat_ip
}

output "load_balancer_ip" {
  value = google_compute_global_address.default.address
}

output "database_connection_names" {
  value = {
    chile   = google_sql_database_instance.chile_db.connection_name
    peru    = google_sql_database_instance.peru_db.connection_name
    ecuador = google_sql_database_instance.ecuador_db.connection_name
  }
}