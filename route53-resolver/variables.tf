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


##
## Outbound Resolver Setting
##
variable "enable_outbound_resolver" {
  description = "Enable the creation of an outbound resolver; default: true"
  type        = bool
  default     = true
}

variable "out_subnet_1_id" {
  description = "Subnet ID to put the first Resolver endpoint in"
  type        = string
}

variable "out_ip1_address" {
  description = "Specify an IP to use in your VPC/Subnet to set the as the resolver endpoint. If left blank one will be auto assigned."
  type        = string
  default     = null
}

variable "out_subnet_2_id" {
  description = "Subnet ID to put the second Resolver endpoint in"
  type        = string
}

variable "out_ip2_address" {
  description = "Specify an IP to use in your VPC/Subnet to set the as the resolver endpoint. If left blank one will be auto assigned."
  type        = string
  default     = null
}

##
## Inbound Resolver Settings
##
variable "enable_inbound_resolver" {
  description = "Enable the creation of an inbound resolver; default: true"
  type        = bool
  default     = true
}
variable "in_subnet_1_id" {
  description = "Subnet ID to put the first Resolver endpoint in"
  type        = string
}

variable "in_ip1_address" {
  description = "Specify an IP to use in your VPC/Subnet to set the as the resolver endpoint. If left blank one will be auto assigned."
  type        = string
  default     = null
}

variable "in_subnet_2_id" {
  description = "Subnet ID to put the second Resolver endpoint in"
  type        = string
}

variable "in_ip2_address" {
  description = "Specify an IP to use in your VPC/Subnet to set the as the resolver endpoint. If left blank one will be auto assigned."
  type        = string
  default     = null
}

##
## Security Group Settings 
##

## The security group will use the forward_rules_map dns server list to specify ingress/egress connectivity to port 53 (udp/tcp) connections
variable "create_security_group" {
  description = "Creates a security group to be used with the In/Out resolvers and use the forward_rules_map dns servers; default: true"
  type        = bool
  default     = true
}

variable "vpc_id" {
  description = "The ID of the VPC to assign the created security group to."
  type        = string
  default     = ""
}

variable "security_group_ids" {
  description = "A list of security groups to be used if not letting the module create one."
  type        = list(string)
  default     = ["", ]
}

##
## Resolver Rules
##

## The Forward resolver rules map. This is a map of dns domains (keys) and a value list of DNS servers that service those domains
variable "forward_rules_map" {
  description = "A Map of the forward rules { \"domain\" : [\"dns server 1\", \"dns server 2\", \"dns server X\"] }"
  type        = map(any)
}