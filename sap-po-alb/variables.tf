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

variable "description" {
  description = "A description of the resource - used in tagging."
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

variable "vpc_id" {
  description = "The VPC to create the security groups, IAM roles, and deploy the Stoage Gateway instance in."
  type        = string
}

variable "subnet_ids" {
  description = "List of the subnets to deploy the ALB to."
  type        = list(string)
}

variable "lb_name" {
  description = "Additional name for the ALB that will be used in the name creation."
  type        = string
}

variable "lb_security_groups_ids" {
  description = "A list of additional security groups that will be assigned to the ALB."
  type        = list(string)
  default     = []
}

variable "lb_ingress_map" {
  description = "A map of ingress security groups."
  type        = map(any)
  default     = {}

}

variable "lb_egress_map" {
  description = "A map of egress security groups."
  type        = map(any)
  default     = {}

}

variable "internal" {
  type        = bool
  default     = false
  description = "A boolean flag to determine whether the ALB should be internal"
}

variable "enable_http2" {
  type        = bool
  default     = true
  description = "A boolean flag to determine whether the ALB should use http2."
}

variable "ip_address_type" {
  description = "Controls the use of ipv4 or a dualstack address type."
  type        = string
  default     = "ipv4"
}

variable "access_logs_bucket" {
  description = "The name of the S3 bucket to use for the access log."
  type        = string
  default     = ""
}

variable "access_logs_prefix" {
  description = "The prefix to use in the of the S3 bucket to use for the access log."
  type        = string
  default     = ""
}

variable "access_logs_enabled" {
  type        = bool
  default     = false
  description = "A boolean flag to determine whether the ALB should use and S3 access log."
}

variable "enable_http" {
  description = "Enable a front end HTTP (Port 80) listener."
  type        = bool
  default     = false
}

variable "enable_https" {
  description = "Enable a front end HTTPS (Port 443) listener."
  type        = bool
  default     = true
}

variable "listener_certificate_arn" {
  description = "The ARN of the Certificate for the HTTPS listener."
  type        = string
  default     = null
}

variable "target_port" {
  description = "The port of for the target group."
  type        = string
  default     = "443"
}

variable "target_protocol" {
  description = "The protocol for the target group (HTTP/HTTPS)"
  type        = string
  default     = "HTTPS"
}

variable "healthcheck_port" {
  description = "The port for the health check. if left blank it will default to the target port."
  type        = string
  default     = null
}

variable "healthcheck_protocol" {
  description = "The protocol for the health check. if left blank it will default to the target protocol."
  type        = string
  default     = null
}

variable "healthcheck_path" {
  description = "The path for the health check. if left blank it will default to the target protocol."
  type        = string
  default     = null
}

variable "stickiness_duration" {
  description = "The duration of the stickiness of the cookie. Default: 1D"
  type        = string
  default     = null
}

## Should really be a list of instances... 
variable "target_instance" {
  description = "The instance id of the target to assign to the target group."
  type        = string
}

variable "forward_rules" {
  description = "A list of listener forward rule paths."
  type        = list(any)
}