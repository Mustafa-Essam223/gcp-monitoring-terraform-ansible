resource "google_compute_instance" "monitoring-server" {
  name         = "monitoring-server"
  description  = "Monitoring server with prometheus and grafana"
  machine_type = "e2-small"
  zone         = var.zone
  tags         = ["monitoring-server"]
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }
  network_interface {
    subnetwork = google_compute_subnetwork.subnet.id
    network_ip = "10.0.0.10"
    access_config {
      // Ephemeral public IP
    }
  }
}
resource "google_compute_instance" "target-server" {
  name         = "target-server"
  description  = "Target server for Node Exporter and Prometheus monitoring"
  machine_type = "e2-small"
  zone         = var.zone
  tags         = ["target-server"]
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
      size  = 10
    }
  }
  network_interface {
    subnetwork = google_compute_subnetwork.subnet.id
    network_ip = "10.0.0.2"
    access_config {
      // Ephemeral public IP
    }
  }
}