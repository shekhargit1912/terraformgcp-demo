output "database_connection_names" {
  value = { for k, v in google_sql_database_instance.databases : k => v.connection_name }
}