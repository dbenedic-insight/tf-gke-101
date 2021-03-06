terraform {
  required_version = "~>0.12.28"
  required_providers {
    google = "~>3.30.0"
  }
}

provider google {
  project = var.project_id
  region  = var.region
}

module "network" {
  source = "./network"

  region               = var.region
  primary_cidr_range   = "192.168.5.0/24"
  secondary_cidr_range = "192.168.6.0/24"
}

output "network" {
  value = module.network
}
