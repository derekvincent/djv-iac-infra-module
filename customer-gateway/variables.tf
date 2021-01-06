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
  default     = "us-east-1"
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