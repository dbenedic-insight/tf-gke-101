variable "project_id" {
  description = "The project ID to host the cluster in"
}

variable "region" {
  description = "The region to host the cluster in"
}

variable "network" {
  description = "The VPC network to host the cluster in"
}

variable "subnetwork" {
  description = "The subnetwork to host the cluster in"
}

variable "ip_range_pods" {
  description = "The secondary ip range to use for pods"
}

variable "ip_range_services" {
  description = "The secondary ip range to use for services"
}

variable "compute_engine_service_account" {
  description = "Service account to associate to the nodes in the cluster"
}

variable "istio" {
  description = "Boolean to enable / disable Istio"
}

variable "cloudrun" {
  description = "Boolean to enable / disable CloudRun"
}

variable "dns_cache" {
  type        = bool
  description = "(Beta) The status of the NodeLocal DNSCache addon."
}

variable "gce_pd_csi_driver" {
  type        = bool
  description = "(Beta) Whether this cluster should enable the Google Compute Engine Persistent Disk Container Storage Interface (CSI) Driver."
}

variable "sandbox_enabled" {
  type        = bool
  description = "(Beta) Enable GKE Sandbox (Do not forget to set `image_type` = `COS_CONTAINERD` and `node_version` = `1.12.7-gke.17` or later to use it)."
}

variable "remove_default_node_pool" {
  type        = bool
  description = "Remove default node pool while setting up the cluster"
}

variable "node_pools" {
  type        = list(map(string))
  description = "List of maps containing node pools"
}

variable "database_encryption" {
  description = "Application-layer Secrets Encryption settings. The object format is {state = string, key_name = string}. Valid values of state are: \"ENCRYPTED\"; \"DECRYPTED\". key_name is the name of a CloudKMS key."
  type        = list(object({ state = string, key_name = string }))
}

variable "enable_binary_authorization" {
  description = "Enable BinAuthZ Admission controller"
}

variable "pod_security_policy_config" {
  description = "enabled - Enable the PodSecurityPolicy controller for this cluster. If enabled, pods must be valid under a PodSecurityPolicy to be created."
}

variable "zones" {
  type        = list(string)
  description = "The zones to host the cluster in (optional if regional cluster / required if zonal)"
}

variable "regional" {
  type        = bool
  description = "Whether is a regional cluster (zonal cluster if set false. WARNING: changing this after cluster creation is destructive!)"
}

variable "skip_provisioners" {
  type        = bool
  description = "Boolean to enable / disable local provisioners"
}
