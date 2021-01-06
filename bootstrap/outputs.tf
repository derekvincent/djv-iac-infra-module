
output "state_bucket_name" {
  value       = aws_s3_bucket.terraform_state.bucket_domain_name
  description = "S3 state bucket domain name"
}
output "state_bucket_id" {
  value       = aws_s3_bucket.terraform_state.id
  description = "S3 state bucket id"
}

output "state_bucket_arn" {
  value       = aws_s3_bucket.terraform_state.arn
  description = "S3 state arn"

}

output "state_lock_table_name" {
  value       = aws_dynamodb_table.terraform_lock.name
  description = "DynamoDB locak table name"
}

output "state_lock_table_id" {
  value       = aws_dynamodb_table.terraform_lock.id
  description = "DynamoDB locak table id"
}

output "state_lock_table_arn" {
  value       = aws_dynamodb_table.terraform_lock.arn
  description = "DynamoDB locak table arn"
}

output "state_policy_name" {
  value       = aws_iam_policy.terraform_state.name
  description = "Terraform State policy."
}

output "state_policy_id" {
  value       = aws_iam_policy.terraform_state.id
  description = "Terraform State policy."
}

output "state_policy_arn" {
  value       = aws_iam_policy.terraform_state.arn
  description = "Terraform State policy."
}

output "terraform_backend_config" {
  value       = data.template_file.terraform_backend_config.rendered
  description = "Rendered Terraform backend config file"
}