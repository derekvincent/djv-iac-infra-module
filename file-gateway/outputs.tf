output "instance" {
  value = aws_instance.file_gateway
}

output "ami_id" {
  value = data.aws_ssm_parameter.latest_ec2.value
}

output "sg_name" {
  value = local.security_group_name
}
