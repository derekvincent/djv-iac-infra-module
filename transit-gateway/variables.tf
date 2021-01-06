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

variable "create_tgw" {
  description = "Controls if TGW should be created (it affects almost all resources)"
  type        = bool
  default     = true
}

variable "amazon_side_asn" {
  description = "The Autonomous System Number (ASN) for the Amazon side of the gateway. By default the TGW is created with the current default Amazon ASN."
  type        = string
  default     = "64512"
}

variable "enable_auto_accept_shared_attachments" {
  description = "Whether resource attachment requests are automatically accepted"
  type        = bool
  default     = true
}

variable "enable_default_route_table_association" {
  description = "Whether resource attachments are automatically associated with the default association route table"
  type        = bool
  default     = true
}

variable "enable_default_route_table_propagation" {
  description = "Whether resource attachments automatically propagate routes to the default propagation route table"
  type        = bool
  default     = true
}

variable "description" {
  description = "Description of the EC2 Transit Gateway"
  type        = string
  default     = null
}

variable "enable_dns_support" {
  description = "Should be true to enable DNS support in the TGW"
  type        = bool
  default     = true
}

variable "enable_vpn_ecmp_support" {
  description = "Whether VPN Equal Cost Multipath Protocol support is enabled"
  type        = bool
  default     = true
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_ids" {
  description = "List of Subnet ID's"
  type        = list(string)
}

variable "destination_cidr" {
  description = "Destination CIDR route for vpc to transit gateway"
  type        = string
}

variable "vpc_route_table_ids" {
  description = "List of route table IDs for the VPC"
  type        = list(any)
  default     = []
}
# // VPC attachments
# variable "vpc_attachments" {
#   description = "Maps of maps of VPC details to attach to TGW. Type 'any' to disable type validation by Terraform."
#   type        = any
#   default     = {}
# }

# // TGW Route Table association and propagation
# variable "transit_gateway_route_table_id" {
#   description = "Identifier of EC2 Transit Gateway Route Table to use with the Target Gateway when reusing it between multiple TGWs"
#   type        = string
#   default     = null
# }