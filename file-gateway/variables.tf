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

variable "sname" {
  description = "Specific name used in the nameing/tagging to distiguish multiple object of the same type."
  type        = string
  default     = ""
}

variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "vpc_id" {
  description = "The VPC to create the security groups, IAM roles, and deploy the Stoage Gateway instance in."
  type        = string
}

variable "subnet_id" {
  description = "The Subnet in the VPC to deployt the File Gateway instance in."
  type        = string
}

variable "ec2_instance_type" {
  description = "The Instance type to deploy the File Gateway on."
  type        = string
  default     = "m5.xlarge"
}

variable "key_name" {
  description = "The name of the SSH key to be used to access the system."
  type        = string
}

variable "root_volume_type" {
  description = "The root volume type."
  type        = string
  default     = "gp2"
}

variable "root_volume_size" {
  description = "The root volume size."
  type        = string
  default     = "80"
}

variable "root_volume_encrypted" {
  description = "The root volume encryption."
  type        = bool
  default     = true
}

variable "cache_volume_type" {
  description = "The cache volume type."
  type        = string
  default     = "gp2"
}

variable "cache_volume_size" {
  description = "The cache volume size."
  type        = string
  default     = "150"
}

variable "cache_volume_encrypted" {
  description = "The cache volume encryption."
  type        = bool
  default     = true
}

variable "enable_enhanced_monitoring" {
  description = "Enable enhanced cloudwatch monitoring."
  type        = bool
  default     = true
}

variable "gateway_name" {
  description = "The gateway hostname."
  type        = string
}

variable "gateway_domain" {
  description = "The dns domain the gateway is deployed in."
  type        = string
}

variable "gateway_time_zone" {
  description = "The time zone the gateway should use.  Entered in the format GMT-5:00"
  type        = string
  default     = "GMT-5:00"
}

variable "admin_cidrs" {
  description = "A list of CIDRs for Admin access over 80/443."
  type        = list(any)
}

variable "ads_cidrs" {
  description = "A CIDR lisr of Active Directory when including the Storage Gateway in AD."
  type        = list(any)
  default     = []
}

variable "nfs_cidrs" {
  description = "A NFS client access list of the CIDRs."
  type        = list(any)
  default     = []
}

variable "enable_nfs_v3" {
  description = "Enable if NFS V3 clients (Windows) need access."
  type        = bool
  default     = false
}

variable "smb_cidrs" {
  description = "A Samba client acces lost of CIDRs."
  type        = list(any)
  default     = []
}

variable "dns_cidrs" {
  description = "A list of CIDRs to allow DNS access for the storage Gateway. If using local AWS Route53 allow access to the local subnet."
  type        = list(any)
}

variable "bucket_arns" {
  description = "A list of Bucket ARNs that the Storage Gateway has access to."
  type        = list(any)
  default     = []
}