
output "s3_id" {
  value       = join("", aws_vpc_endpoint.s3.*.id)
  description = "The ID of the VPC"
}

output "s3_arn" {
  value       = join("", aws_vpc_endpoint.s3.*.arn)
  description = "The ID of the VPC"
}
