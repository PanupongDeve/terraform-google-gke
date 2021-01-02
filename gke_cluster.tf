



module "gke"  {
    source                      = "terraform-google-modules/kubernetes-engine/google"
    project_id                  = var.google_project_id
    name                        = var.cluster_name
    region                      = var.region
    zones                       = local.zones
    network                     = module.network.network_name
    subnetwork                  = "private-subnet-01"
    ip_range_pods               = "private-subnet-01-pods"
    ip_range_services           = "private-subnet-01-service"
    http_load_balancing         = true
    horizontal_pod_autoscaling  = true
    network_policy              = true
    create_service_account      = false
    service_account             = var.cluster_service_account

    node_pools = [
    {
      name               = "default-node-pool"
      machine_type       = "e2-medium"
      node_locations     = local.node_locations
      min_count          = 1
      max_count          = 100
      service_account    = var.cluster_service_account
      preemptible        = true
      initial_node_count = 1
    },
  ]
}