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

variable "gateway_arn" {
  description = "The Storage Gateway arn to create the file share against."
  type        = string
}

variable "client_list" {
  description = "The client CIDRs allowed to access the Storage Gateway."
  type        = list(string)
}

variable "location_arn" {
  description = "The arn of the source bucket."
  type        = string
}

variable "role_arn" {
  description = "The rle arn that the storage gateway uses to access the bucket."
  type        = string
}

variable "file_share_name" {
  description = "The name of the file to be created. Required if using a bucket prefix."
  type        = string
  default     = null
}

variable "cache_ttl" {
  description = "Cache time-to-live on the share when the cache is refreshed."
  type        = string
  default     = "600"
}

variable "default_storage_class" {
  description = "The storage class for object placed in the bucket via the file gateway. Options: S3_STANDARD, S3_STANDARD_IA, and S3_ONEZONE_IA."
  type        = string
  default     = "S3_STANDARD"
}

variable "notification_time" {
  description = "The time in seconds that an upload event will be sent on a change. A 0 disables the notification."
  type        = number
  default     = 0
}

variable "directory_mode" {
  description = "The unix directory mode."
  type        = string
  default     = "0777"
}

variable "file_mode" {
  description = "The unix file mode."
  type        = string
  default     = "0666"
}

variable "group_id" {
  description = "The default unix group id for the file share."
  type        = string
  default     = "65534"
}

variable "owner_id" {
  description = "The default unix owner id for the file share."
  type        = string
  default     = "65534"
}

variable "squash" {
  description = "Maps a user to anonymous user. Defaults to AllSquash. Valid values: RootSquash (only root is mapped to anonymous user), NoSquash (no one is mapped to anonymous user), AllSquash (everyone is mapped to anonymous user)"
  type        = string
  default     = "AllSquash"
}