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

variable "enable_s3_endpoint" {
  description = "Enable the creation of the S3 Endpoint; default: false"
  type        = bool
  default     = false
}

variable "vpc_id" {
  description = "VPC ID to attach the endpoint to."
  type        = string
}

variable "route_table_ids" {
  description = "List of route table IDs for the VPC"
  type        = list(any)
  default     = []
}
