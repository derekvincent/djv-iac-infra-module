
variable "vpc_id" {
  description = "VPC the Virtual Private Gateway will be associated with."
  type        = string
}

variable "amazon_side_asn" {
  description = "The BGP ASN to assign to the Virtual Private Gateway."
  type        = string
  default     = "4512"
}

variable "route_table_ids" {
  description = "A list of route table IDs to assign Virtual Private Gateway with propogation."
  type        = list(string)
}

variable "dx_gateway_id" {
  description = "The Direct Connect Gateway ID to attach to."
  type        = string
}

variable "dx_gateway_account_id" {
  description = "The Account ID of the Direct Connect Gateway to attach to."
  type        = string
}