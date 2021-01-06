output "bucket_name" {
  value       = aws_s3_bucket.bucket.bucket_domain_name
  description = "S3 state bucket domain name"
}
output "bucket_id" {
  value       = aws_s3_bucket.bucket.id
  description = "S3 state bucket id"
}

output "bucket_arn" {
  value       = aws_s3_bucket.bucket.arn
  description = "S3 state arn"

}