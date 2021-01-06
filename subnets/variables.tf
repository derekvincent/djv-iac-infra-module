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

## Subnet Type
variable "type" {
  type        = string
  default     = "private"
  description = "Type of subnets (`private` or `public`)"
}

## Public Subnet

variable "public_subnets" {
  description = "A list of subnet CIDRs"
  type        = map(any)
  default     = {}
}

variable "igw_id" {
  description = "VPC Internet Gateway ID"
  type        = string
  default     = ""
}

variable "enable_nat_gateway" {
  description = "Enable Nat Gateway"
  type        = bool
  default     = false
}

## Private Subnet

## Map of pivate subnets - { avaliablity_zone = "CIDR"}
## {
##      us-east-2a = "10.0.0.0/26"
##      us-east-2b = "10.0.0.0/26"
## }

variable "private_subnets" {
  description = "A list of subnet CIDRs"
  type        = map(any)
  default     = {}
}

variable "ngw_id" {
  description = "NAT Gateway ID"
  type        = string
  default     = ""
}




