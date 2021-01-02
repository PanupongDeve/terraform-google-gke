
resource "google_compute_firewall" "default" {
    name    = "ssh-terraform"
    network = module.network.network_name

    depends_on = [
        module.network.network_name
    ]

    allow {
        protocol = "tcp"
        ports    = ["22"]
    }

    priority = 65534
    source_ranges = [ "0.0.0.0/0" ]

}

resource "google_compute_firewall" "internal" {
    name    = "allow-internal-terraform"
    network = module.network.network_name

    depends_on = [
        module.network.network_name
    ]

    allow {
        protocol = "tcp"
        ports    = ["0-65535"]
    }

    allow {
        protocol = "udp"
        ports    = ["0-65535"]
    }

    allow {
        protocol = "icmp"
    }

    priority = 65534
    source_ranges = [ "10.0.0.0/16" ]

}
