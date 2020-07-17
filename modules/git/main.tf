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
  source = "git::https://github.com/dbenedic-insight/tf-gke-101//modules/git/network?refs/heads/main"
 
  region = var.region
  primary_cidr_range = "192.168.5.0/24"
  secondary_cidr_range = "192.168.6.0/24"
}

output "network" {
  value = module.network
}
