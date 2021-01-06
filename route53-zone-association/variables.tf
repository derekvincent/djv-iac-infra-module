
variable "zone_id" {
  description = "Zone ID of the Route53 domain"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID to associate to the Route53 domain"
  type        = string
}
