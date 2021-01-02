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

variable "k8s_subnet_name" {
  default = "cluster-subnet"
}

locals {
  zones = ["${var.region}-a", "${var.region}-b", "${var.region}-c"]
  ip_range_pods = "${var.k8s_subnet_name}-pods"
  ip_range_services = "${var.k8s_subnet_name}-services"
}