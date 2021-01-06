## Labels
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

## VPC 
variable "vpc_id" {
  description = "VPC ID the subnet will be created in."
  type        = string
}

## Route53 Settings
variable "dns_domain_name" {
  type        = string
  description = "DNS Domain Name"
}