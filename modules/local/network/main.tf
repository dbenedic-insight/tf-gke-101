resource "google_compute_network" "main" {
  name        = "demo"
  description = "demo network"

  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "main" {
  name          = "subnet-1a"
  region        = var.region
  ip_cidr_range = var.primary_cidr_range
  network       = google_compute_network.main.self_link

  secondary_ip_range {
    range_name    = "subnet-1b"
    ip_cidr_range = var.secondary_cidr_range
  }
}

output "network" {
  value = {
    name        = google_compute_network.main.name
    description = google_compute_network.main.description
    primary = {
      name  = google_compute_subnetwork.main.name
      range = google_compute_subnetwork.main.ip_cidr_range
    }
    secondary = {
      name  = google_compute_subnetwork.main.secondary_ip_range[0].range_name
      range = google_compute_subnetwork.main.secondary_ip_range[0].ip_cidr_range
    }
  }
}
