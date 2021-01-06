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

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet ID's"
  type        = list(string)
}

variable "transit_gateway_id" {
  description = "Transit Gateway ID"
  type        = string
}

variable "destination_cidr" {
  description = "Target route CIDR"
  type        = string
}

variable "route_table_ids" {
  description = "List of VPC route table IDs"
  type        = list(string)
}