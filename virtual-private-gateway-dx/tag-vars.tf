variable "namespace" {
  description = "Namespace - used in tagging and name generation."
  type        = string
  default     = ""
}


variable "environment" {
  description = "Environment - used in tagging and name generation."
  type        = string
  default     = ""
}

variable "name" {
  description = "Name or application - used in tagging and name generation"
  type        = string
}

variable "customer" {
  description = "Customer (internal/external) Name - billing tag"
  type        = string
}
variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}