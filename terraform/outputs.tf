output "monitoring_public_ip" {
  value = google_compute_instance.monitoring-server.network_interface[0].access_config[0].nat_ip
}

output "target_public_ip" {
  value = google_compute_instance.target-server.network_interface[0].access_config[0].nat_ip
}

output "monitoring_private_ip" {
  value = google_compute_instance.monitoring-server.network_interface[0].network_ip
}
output "target_private_ip" {
  value = google_compute_instance.target-server.network_interface[0].network_ip
}