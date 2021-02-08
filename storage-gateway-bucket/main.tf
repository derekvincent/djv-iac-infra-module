##
## For now simple buckets plus a storage GW policy. 
##

locals {
  bucket_name = var.custom_bucket_name ? var.bucket_name : join("-", [var.namespace, var.name, var.environment, var.bucket_name])

  role_name   = join("-", [local.bucket_name, "file-gateway", "role"])
  policy_name = join("-", [local.bucket_name, "file-gateway", "policy"])

  is_shared_account = var.shared_account_id == "" ? false : true

  tag_name_env         = join(":", [var.namespace, "environment"])
  tag_name_customer    = join(":", [var.namespace, "customer"])
  tag_name_application = join(":", [var.namespace, "application"])

  common_tags = map(
    local.tag_name_env, var.environment,
    local.tag_name_customer, var.customer,
    local.tag_name_application, var.name,
  )
}

## Bucket Setup 
resource "aws_s3_bucket" "storage_gateway" {
  bucket = local.bucket_name #tfsec:ignore:AWS002
  acl    = "private"
  policy = local.is_shared_account ? data.aws_iam_policy_document.s3_shared_account.json : {}

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
  bucket                  = aws_s3_bucket.storage_gateway.id
  block_public_acls       = var.block_public_acls
  ignore_public_acls      = var.ignore_public_acls
  block_public_policy     = var.block_public_policy
  restrict_public_buckets = var.restrict_public_buckets
}

data "aws_iam_policy_document" "s3_shared_account" {

  statement {
    effect = "Allow"
    actions = [
      "s3:CreateBucket",
      "s3:GetBucketLocation",
      "s3:GetObject",
      "s3:PutObject",
      "s3:PutObjectRetention",
      "s3:PutObjectTagging",
      "s3:ListBucket",
      "s3:ListAllMyBuckets",
      "s3:DeleteObject",
      "s3:GetObjectAcl",
      "s3:PutObjectAcl"
    ]
    principals {
      type        = "AWS"
      identifiers = format("arn:aws:iam::%s:root", var.shared_bucket_id)
    }
    resources = [format("arn:aws:s3:::%s", local.bucket_name)]
  }
}