variable "region" {
  description = "The region to host the cluster in"
}

variable "primary_cidr_range" {
  description = "CIDR range of the primary subnet"
}

variable "secondary_cidr_range" {
  description = "CIDR range of the secondary subnet"
}
