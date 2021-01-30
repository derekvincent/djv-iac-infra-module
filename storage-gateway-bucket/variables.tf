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
##
##

variable "bucket_name" {
  description = "The bucket postfix name or full named based on the custom_bucket_name setting."
  type        = string
}

variable "custom_bucket_name" {
  description = "If set to false then the bucket_name will have the standard determined prefix applied. If it is set to true then the only provided bucket name will be used. default: false"
  type        = bool
  default     = false
}

# variable "enable_versioning" {
#   description = "Enable bucket versioning; default: false"
#   type        = bool
#   default     = false
# }

variable "block_public_acls" {
  description = "Block Public acls; default: true"
  type        = bool
  default     = true
}

variable "ignore_public_acls" {
  description = "Ignore Public acls; default: true"
  type        = bool
  default     = true
}

variable "block_public_policy" {
  description = "Block Public policy; default: true"
  type        = bool
  default     = true
}

variable "restrict_public_buckets" {
  description = "Restrict Public buckets; default: true"
  type        = bool
  default     = true
}
