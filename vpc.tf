module "network" {
    source  = "terraform-google-modules/network/google"
    version = "3.0.0"
    # insert the 3 required variables here

    project_id   = var.google_project_id
    network_name = var.project_name

    subnets = [
        {
            subnet_name           = "public-subnet-01"
            subnet_ip             = "10.0.0.0/16"
            subnet_region         = var.region
        },
        {
            subnet_name           = "private-subnet-01"
            subnet_ip             = "10.101.0.0/16"
            subnet_region         = var.region
            subnet_private_access = "true"
        }
    ]

    secondary_ranges = {
        private-subnet-01 = [
            {
                range_name    = "private-subnet-01-pods"
                ip_cidr_range = "192.168.0.0/18"
            },
            {
                range_name    = "private-subnet-01-service"
                ip_cidr_range = "192.168.64.0/18"
            },
        ]
    }

}