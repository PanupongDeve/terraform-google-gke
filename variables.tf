variable "project_name" {
    default = "terraform-vpc"
}

variable "region" {
    default = "asia-southeast1"
}

variable "zone" {
    default = "asia-southeast1-a"
}

variable "google_project_id" {
    default = "seed-iam"
}

variable "cluster_name" {
  default = "terraform-gke-cluster"
}

variable "cluster_service_account" {
  default = "k8s-cluster-admin@seed-iam.iam.gserviceaccount.com"
}


locals {
  zones = ["${var.region}-a", "${var.region}-b", "${var.region}-c"]
  node_locations = "${var.region}-a"
}