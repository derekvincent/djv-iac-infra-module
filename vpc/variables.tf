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

variable "vpc_cidr" {
  description = "CIRD for the VPC"
}

variable "enable_dns_hostname" {
  description = "A boolean flag to enable/disable DNS hostnames in the VPC."
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "A boolean flag to enable/disable DNS support in the VPC."
  type        = bool
  default     = true
}

variable "enable_internet_gateway" {
  description = "Enable th creation of an internet gateway for the VPC"
  type        = bool
  default     = true

}

variable "dns_domain_name" {
  description = "Default DNS Domain Name for the VPC - Sets in the DHCP OPtion Set"
  type        = string
}

variable "dns_server_list" {
  description = "List of DNS Servers"
  type        = list(any)
  default     = ["AmazonProvidedDNS", ]
}