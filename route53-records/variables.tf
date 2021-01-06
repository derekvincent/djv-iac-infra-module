variable "type" {
  description = "The record type to create. Currrently only A and CNAME support."
  type        = string
}

variable "ttl" {
  description = "The Time-To-Live of the records being added; default: 300"
  type        = string
  default     = "300"
}

variable "zone_id" {
  description = "The Zone ID the record is being added to."
  type        = string
}

variable "name" {
  description = "The record name that is being added."
  type        = string
}

variable "records" {
  description = "A list of the records being added. ie: IP addresses or other alias."
  type        = list(any)
}