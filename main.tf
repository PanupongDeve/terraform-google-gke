provider "google" {
  credentials = file("./credentials.json")

  project = var.google_project_id
  region  = var.region
  zone    = var.zone
}



module "network" {
  source  = "terraform-google-modules/network/google"
  version = "3.0.0"
  # insert the 3 required variables here

  project_id   = var.google_project_id
  network_name = var.project_name

  subnets = [
        {
            subnet_name           = "subnet-01"
            subnet_ip             = "10.10.10.0/24"
            subnet_region         = var.region
        },
        {
            subnet_name           = "subnet-02"
            subnet_ip             = "10.10.20.0/24"
            subnet_region         = var.region
            subnet_private_access = "true"
            description           = "This subnet has a description"
        }
    ]

}

module "gke"  {
    source                      = "terraform-google-modules/kubernetes-engine/google"
    project_id                  = var.google_project_id
    name                        = var.cluster_name
    region                      = var.region
    zones                       = local.zones
    network                     = module.network.network_name
    subnetwork                  = "subnet-02"
    ip_range_pods               = local.ip_range_pods
    ip_range_services           = local.ip_range_services
    http_load_balancing         = true
    horizontal_pod_autoscaling  = true
    network_policy              = true
}



resource "google_compute_firewall" "default" {
    name    = "ssh-terraform"
    network = module.network.network_name

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
