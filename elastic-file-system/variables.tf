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

variable "description" {
  description = "EFS Usage Description"
  type        = string
}

variable "detail_name" {
  description = "Additional Detailed name - <namespace>-<name>-<environment>-<detail_name>-efs: clkwrk-sap-shared-trans-efs."
  type        = string
}

variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "mount_subnets" {
  description = "List of subnet IDs to create mount targets in."
  type        = list(any)
}

## VPC 
variable "vpc_id" {
  description = "VPC ID the subnet will be created in."
  type        = string
}

variable "access_points" {
  description = "A list of access points to be created "
  #type = list
  #default = []
  type    = map(any)
  default = {}
}

## Security Group 
variable "security_group_cidrs" {
  description = "A list of CIDRS that are allowed access to the EFS file system."
  type        = list(string)
  default     = []
}

variable "security_group_prefix_list_ids" {
  description = "A list of Prefix Lists that are allowed access to the EFS file system."
  type        = list(string)
  default     = []
}

variable "transition_to_ia" {
  type        = string
  description = "Indicates how long it takes to transition files to the IA storage class. Valid values: AFTER_7_DAYS, AFTER_14_DAYS, AFTER_30_DAYS, AFTER_60_DAYS and AFTER_90_DAYS"
  default     = ""
}