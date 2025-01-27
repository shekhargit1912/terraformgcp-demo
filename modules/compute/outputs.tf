output "instance_group_id" {
  value = google_compute_instance_group.app_group.id
}

output "jumpbox_public_ip" {
  value = google_compute_instance.jumpbox.network_interface[0].access_config[0].nat_ip
}