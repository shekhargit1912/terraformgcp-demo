output "jumpbox_public_ip" {
  value = module.compute.jumpbox_public_ip
}

output "load_balancer_ip" {
  value = module.load_balancer.load_balancer_ip
}

output "database_connection_names" {
  value = module.database.database_connection_names
}