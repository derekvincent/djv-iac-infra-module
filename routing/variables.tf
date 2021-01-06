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

variable "route_table_id" {
  description = "Route Table ID"
  type        = string
}

variable "destination_cidr_blocks" {
  description = "List of CIDR targets blocks"
  type        = list(any)
  default     = []
}

variable "transit_gateway_id" {
  description = "Transit Gateway ID"
  type        = string
  default     = null
}

variable "vpc_peering_id" {
  description = "VPC Perring Connection ID"
  type        = string
  default     = null
}