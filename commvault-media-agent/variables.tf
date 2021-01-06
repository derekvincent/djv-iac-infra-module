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
  type        = string
  default     = "us-east-1"
}

variable "instance_name" {
  description = "Name for the Instance."
  type        = string
}

variable "iam_instance_profile" {
  description = "The name of the IAM instance profile to assign to the instance."
  type        = string
  default     = ""
}

variable "hostname" {
  description = "Hostname of the instance used for tagging."
  type        = string
  default     = ""
}
## 
## EC2 Creation Values
##

variable "ec2_ami" {
  description = "AMI for the Instance being created."
  type        = string
}

variable "ec2_instance_type" {
  description = "EC2 Instance Type."
  type        = string
}

variable "key_name" {
  description = "EC2 instance keypair to use."
  type        = string
}

variable "subnet_id" {
  description = "VPC Subnet ID to deploy the instnace in."
  type        = string
}

variable "enable_enhanced_monitoring" {
  description = "Enable Enhanced Cloudwatch Monitoring; default: true."
  type        = bool
  default     = true
}

variable "enable_public_address" {
  description = "Enable assignment of a public address when in a public subnet; default: false."
  type        = bool
  default     = false
}

variable "ec2_private_ip" {
  description = "Sets the instances IP address. If not set then a random subnet IP address will be used."
  type        = string
  default     = null
}

variable "ebs_optimized" {
  description = "Enable the EBS optimization on the instance if support; default: false"
  type        = bool
  default     = false
}

variable "termination_protection" {
  description = "Instance termination protection default:true."
  type        = bool
  default     = true
}

variable "root_volume_type" {
  description = "Root Volume type - standard, gp2, io1 or io2; default: gp2)."
  type        = string
  default     = "gp2"
}

variable "root_volume_size" {
  description = "Root Volume size; default: 20."
  type        = string
  default     = "20"
}

variable "root_volume_encrypted" {
  description = "Enable Root Volume Encryption; default: true."
  type        = bool
  default     = true
}

variable "swap_volume_type" {
  description = "Swap Volume type - standard, gp2, io1 or io2; default: standard)."
  type        = string
  default     = "standard"
}

variable "swap_volume_size" {
  description = "Swap Volume size."
  type        = string
}

variable "swap_volume_encrypted" {
  description = "Enable Swap Volume Encryption; default: true."
  type        = bool
  default     = true
}

variable "ebs_disk_layouts" {
  description = "Map of the additional ebs values to be added."
  type        = map(any)
}


variable "assumed_shared_roles" {
  description = "List of possible roles that the instance can assume."
  type        = list(string)
  default     = []
}

variable "security_groups" {
  description = "List of Security groups to add to the instance."
  type        = list(any)
  default     = []
}