output "bucket_arn" {
  value = aws_s3_bucket.storage_gateway.arn
}

output "bucket_name" {
  value = aws_s3_bucket.storage_gateway.id
}

output "bucket_domain_name" {
  value = aws_s3_bucket.storage_gateway.bucket_domain_name
}

output "bucket_role_arn" {
  value = aws_iam_role.role.arn
}