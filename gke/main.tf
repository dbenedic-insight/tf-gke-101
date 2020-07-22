module "gke" {
  source                      = "app.terraform.io/cardinalsolutions/kubernetes-engine/google//modules/beta-public-cluster"
  version                     = "9.2.0"
  project_id                  = var.project_id
  name                        = "${var.region}-simple-regional-beta"
  regional                    = var.regional
  region                      = var.region
  zones                       = var.zones
  network                     = var.network
  subnetwork                  = var.subnetwork
  ip_range_pods               = var.ip_range_pods
  ip_range_services           = var.ip_range_services
  create_service_account      = var.compute_engine_service_account == "create"
  service_account             = var.compute_engine_service_account
  istio                       = var.istio
  cloudrun                    = var.cloudrun
  dns_cache                   = var.dns_cache
  gce_pd_csi_driver           = var.gce_pd_csi_driver
  sandbox_enabled             = var.sandbox_enabled
  remove_default_node_pool    = var.remove_default_node_pool
  node_pools                  = var.node_pools
  database_encryption         = var.database_encryption
  enable_binary_authorization = var.enable_binary_authorization
  pod_security_policy_config  = var.pod_security_policy_config
  release_channel             = "REGULAR"
  skip_provisioners           = var.skip_provisioners

  # Disable workload identity
  identity_namespace = null
  node_metadata      = "UNSPECIFIED"
}



