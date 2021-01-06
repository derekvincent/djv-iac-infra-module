locals {
  bucket_name = var.custom_bucket_name ? var.bucket_name : join("-", [var.namespace, var.name, var.environment, var.region, var.bucket_name])
  #    policy_name = var.state_policy_name != null ? var.state_policy_name : join("-", [var.namespace, var.name, var.environment, "remote-state-policy"])


  tag_name_env      = join(":", [var.namespace, "environment"])
  tag_name_customer = join(":", [var.namespace, "customer"])
  common_tags = map(
    local.tag_name_env, var.environment,
    local.tag_name_customer, var.customer
  )
}

## Bucket Setup 
resource "aws_s3_bucket" "bucket" {
  bucket = local.bucket_name

  versioning {
    enabled = var.enable_versioning
  }

  # Enable server-side encryption by default
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  # lifecycle_rule {
  #     id      = join("-", [local.bucket_name, "lifecycle-policy"])
  #     prefix  = var.lifecycle_prefix
  #     enabled = true

  #     noncurrent_version_transition {
  #         days          = var.standard_ia_days
  #         storage_class = "STANDARD_IA"
  #     }
  #     noncurrent_version_transition {
  #         days          = var.glacier_days
  #         storage_class = "GLACIER"
  #     }

  #     tags = local.common_tags
  # }

  tags = local.common_tags
}


resource "aws_s3_bucket_public_access_block" "default" {
  bucket                  = aws_s3_bucket.bucket.id
  block_public_acls       = var.block_public_acls
  ignore_public_acls      = var.ignore_public_acls
  block_public_policy     = var.block_public_policy
  restrict_public_buckets = var.restrict_public_buckets
}
