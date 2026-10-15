resource "google_compute_network" "main-vpc" {
  name                    = "vpc-network"
  auto_create_subnetworks = false
}


resource "google_compute_subnetwork" "subnet" {
  name          = "subnet-a"
  ip_cidr_range = "10.0.0.0/24"
  region        = var.region
  network       = google_compute_network.main-vpc.id
}


resource "google_compute_firewall" "allow-admin-ssh" {
  name        = "allow-admin-ssh"
  description = "Allow SSH, HTTP, and HTTPS from my public IP (mostafa public IP)"

  network = google_compute_network.main-vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22", "3000", "9090"]
  }

  source_ranges = [var.my_ip_cidr]
  target_tags   = ["monitoring-server"]
}

resource "google_compute_firewall" "allow_ssh_target" {
  name    = "allow-ssh-target"
  network = google_compute_network.main-vpc.name
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = [var.my_ip_cidr]
  target_tags   = ["target-server"]
}

resource "google_compute_firewall" "allow_node_exporter_internal" {
  name        = "allow-node-exporter-internal"
  description = "Allow Prometheus (monitoring-server) to scrape node_exporter on target-server"

  network = google_compute_network.main-vpc.name

  allow {
    protocol = "tcp"
    ports    = ["9100"]
  }

  source_tags = ["monitoring-server"]
  target_tags = ["target-server"]
}
