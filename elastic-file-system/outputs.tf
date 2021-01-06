output "efs_id" {
  value = aws_efs_file_system.default.id
}

output "efs_arn" {
  value = aws_efs_file_system.default.arn
}

output "efs_domain_name" {
  value = aws_efs_file_system.default.dns_name
}

output "mount_targets" {
  value = aws_efs_mount_target.default.*
}

output "mount_targets_ips_as_cidr" {
  value = formatlist("%s/32", aws_efs_mount_target.default.*.ip_address)
}

output "access_points" {
  value = aws_efs_access_point.default
}

