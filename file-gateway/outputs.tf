output "instance" {
  value = aws_instance.file_gateway
}

output "ami_id" {
  value = data.aws_ssm_parameter.latest_ec2.value
}

output "sg_name" {
  value = local.security_group_name
}

output "fqdn" {
  description = "The fully qualified domain name."
  value       = join(".", [var.gateway_name, var.gateway_domain])
}

output "file_gateway_arn" {
  description = "The arn of the file gateway."
  value       = aws_storagegateway_gateway.file_gateway.id
}

output "file_gateway_role_arn" {
  value = aws_iam_role.file_gateway.arn
}