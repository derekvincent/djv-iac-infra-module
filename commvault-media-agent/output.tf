output "instance" {
  value = aws_instance.commvault_media_agent
}

output "ebs_volumes" {
  value = aws_ebs_volume.default
}

output "ebs_volume_attachments" {
  value = aws_volume_attachment.default
}
