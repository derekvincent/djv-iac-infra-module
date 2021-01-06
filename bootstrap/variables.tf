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

## Bucket Inputs 
variable "state_bucket_name" {
  description = "Use this to override the default bucket name <namespace>-<name>-<environment>-terraform-state"
  default     = null
}

variable "lifecycle_prefix" {
  description = "Use this to set the prefix used by the lifecycle policy, if not used then entire bucket is set. Ensure all states are in that prefix."
  default     = null
}

variable "standard_ia_days" {
  description = "Number of days before non current versions are moved to Standard IA. Default: 30"
  default     = 30
}

variable "glacier_days" {
  description = "Number of days before non current versions are moved to Glacier. Default: 90"
  default     = 90
}

variable "state_table_name" {
  description = "Use this to override the default table name <namespace>-<name>-<environment>-remote-state"
  type        = string
  default     = null
}

variable "state_policy_name" {
  description = "Use this to override the default policy name <namespace>-<name>-<environment>-remote-state-policy"
  type        = string
  default     = null
}

variable "terraform_version" {
  description = "The minimum required terraform version"
  type        = string
  default     = "0.13"
}

variable "terraform_state_file" {
  description = "The path to the state file inside the bucket"
  type        = string
  default     = "global/s3state/terraform.tfstate"
}