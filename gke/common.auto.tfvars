network                  = "default"
subnetwork               = "default"
ip_range_pods            = ""
ip_range_services        = ""
skip_provisioners        = true
istio                    = true
cloudrun                 = true
dns_cache                = false
gce_pd_csi_driver        = false
sandbox_enabled          = false
remove_default_node_pool = false
node_pools = [
  {
    name = "default-node-pool"
  }
]
database_encryption = [
  {
    state    = "DECRYPTED"
    key_name = ""
  }
]
enable_binary_authorization = false
pod_security_policy_config = [
  {
    enabled = false
  }
]
zones    = []
regional = true
