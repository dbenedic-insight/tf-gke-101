terraform {
  required_version = "~>0.12.28"

  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "cardinalsolutions"
    workspaces {
      name = "gcp-terraform-gke-beta"
    }
  }
}

provider "google-beta" {
  version = "~>3.23.0"
  project = var.project_id
  region  = var.region
}
