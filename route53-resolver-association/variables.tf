variable "resolver_rule_ids" {
  description = "List of Route53 Resolver Rules ID's to associate to the VPC."
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID to assicate to the Route53 Resolver Rules."
  type        = string
}