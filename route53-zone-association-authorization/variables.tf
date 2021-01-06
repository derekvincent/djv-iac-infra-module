variable "vpc_id" {
  description = "VPC ID of the association in the non-hosting zone."
  type        = string
}

variable "zone_id" {
  description = "The Route53 zone ID to authorize the association"
  type        = string
}
