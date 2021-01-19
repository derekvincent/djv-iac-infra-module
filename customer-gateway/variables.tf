variable "namespace" {
  description = "Namespace - 'clk' or 'clklab' "
  type        = string
  default     = ""
}

variable "environment" {
  description = "Environment - eg. 'sbx', 'dev','qa','prod'"
  type        = string
  default     = ""
}

variable "name" {
  description = "Name"
  type        = string
}

variable "customer" {
  description = "Customer Name - billing tag"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}


variable "target" {
  description = "The VPN partner or target name being deployed for."
  type        = string
}
variable "bgp_asn" {
  description = "BGP ASN"
  type        = string
  default     = "65000"
}

variable "ip_address" {
  description = "Customer VPN IP address"
  type        = string
}

variable "type" {
  description = "Customer Gateway Type. Only supported type currently is ipsec.1"
  type        = string
  default     = "ipsec.1"
}

variable "transit_gateway_id" {
  description = "Transit Gateway ID to attachment to"
  type        = string

}

variable "static_routes_only" {
  description = "Determine if the VPN will static route of BGP."
  type        = bool
  default     = false
}

variable "target_static_route_cidrs" {
  description = "A list of CIDR's that will be added to the static route table for the VPN connection"
  type        = list(any)
  default     = []
}

variable "transit_gateway_route_table_id" {
  description = "The ID of the Transit Gateway route table you want to add the VPN target routes to."
  type        = string
  default     = ""
}


variable "tunnel1_ike_versions" {
  description = "IKE Version [ikev1, ikev2]"
  type        = list(string)
  default     = null
}

variable "tunnel1_phase1_dh_group_numbers" {
  description = "Phase 1 DH group numbers [ 2 | 14 | 15 | 16 | 17 | 18 | 19 | 20 | 21 | 22 | 23 | 24 ]."
  type        = list(number)
  default     = null
}

variable "tunnel1_phase1_encryption_algorithms" {
  description = "Phase 1 encryption algorithms [ ES128 | AES256 | AES128-GCM-16 | AES256-GCM-16 ]."
  type        = list(string)
  default     = null
}

variable "tunnel1_phase1_integrity_algorithms" {
  description = "Phase 1 integrity algorithms [ SHA1 | SHA2-256 | SHA2-384 | SHA2-512 ]."
  type        = list(string)
  default     = null
}

variable "tunnel1_phase2_dh_group_numbers" {
  description = "Phase 2 DH group numbers [ 2 | 5 | 14 | 15 | 16 | 17 | 18 | 19 | 20 | 21 | 22 | 23 | 24 ]."
  type        = list(number)
  default     = null
}

variable "tunnel1_phase2_encryption_algorithms" {
  description = "Phase 2 encryption algorithms [ AES128 | AES256 | AES128-GCM-16 | AES256-GCM-16 ]."
  type        = list(string)
  default     = null
}

variable "tunnel1_phase2_integrity_algorithms" {
  description = "Phase 2 integrity algorithms [ SHA1 | SHA2-256 | SHA2-384 | SHA2-512 ]."
  type        = list(string)
  default     = null
}

variable "tunnel2_ike_versions" {
  description = "IKE Version [ikev1, ikev2]"
  type        = list(string)
  default     = null
}

variable "tunnel2_phase1_dh_group_numbers" {
  description = "Phase 1 DH group numbers [ 2 | 14 | 15 | 16 | 17 | 18 | 19 | 20 | 21 | 22 | 23 | 24 ]."
  type        = list(number)
  default     = null
}

variable "tunnel2_phase1_encryption_algorithms" {
  description = "Phase 1 encryption algorithms [ ES128 | AES256 | AES128-GCM-16 | AES256-GCM-16 ]."
  type        = list(string)
  default     = null
}

variable "tunnel2_phase1_integrity_algorithms" {
  description = "Phase 1 integrity algorithms [ SHA1 | SHA2-256 | SHA2-384 | SHA2-512 ]."
  type        = list(string)
  default     = null
}

variable "tunnel2_phase2_dh_group_numbers" {
  description = "Phase 2 DH group numbers [ 2 | 5 | 14 | 15 | 16 | 17 | 18 | 19 | 20 | 21 | 22 | 23 | 24 ]."
  type        = list(number)
  default     = null
}

variable "tunnel2_phase2_encryption_algorithms" {
  description = "Phase 2 encryption algorithms [ AES128 | AES256 | AES128-GCM-16 | AES256-GCM-16 ]."
  type        = list(string)
  default     = null
}

variable "tunnel2_phase2_integrity_algorithms" {
  description = "Phase 2 integrity algorithms [ SHA1 | SHA2-256 | SHA2-384 | SHA2-512 ]."
  type        = list(string)
  default     = null
}