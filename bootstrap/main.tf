locals {
  bucket_name   = var.state_bucket_name != null ? var.state_bucket_name : join("-", [var.namespace, var.name, var.environment, var.region, "remote-state"])
  dynamodb_name = var.state_table_name != null ? var.state_table_name : join("-", [var.namespace, var.name, var.environment, "remote-state-lock"])
  policy_name   = var.state_policy_name != null ? var.state_policy_name : join("-", [var.namespace, var.name, var.environment, "remote-state-policy"])

  terraform_backend_config_template_file = "${path.module}/template/terraform.tf.tpl"

  tag_name_env      = join(":", [var.namespace, "environment"])
  tag_name_customer = join(":", [var.namespace, "customer"])
  common_tags = map(
    local.tag_name_env, var.environment,
    local.tag_name_customer, var.customer
  )
}

## Bucket Setup 
resource "aws_s3_bucket" "terraform_state" {
  bucket = local.bucket_name

  # Enable versioning so we can see the full revision history of our
  # state files
  versioning {
    enabled = true
  }

  # Enable server-side encryption by default
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  lifecycle_rule {
    id      = join("-", [local.bucket_name, "lifecycle-policy"])
    prefix  = var.lifecycle_prefix
    enabled = true

    noncurrent_version_transition {
      days          = var.standard_ia_days
      storage_class = "STANDARD_IA"
    }
    noncurrent_version_transition {
      days          = var.glacier_days
      storage_class = "GLACIER"
    }

    tags = local.common_tags
  }

  tags = local.common_tags
}

## Bloack All Public Access to the Remote State S3 Bucket
resource "aws_s3_bucket_public_access_block" "default" {
  bucket                  = aws_s3_bucket.terraform_state.id
  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

## Create the DynamoDB lock table
resource "aws_dynamodb_table" "terraform_lock" {
  name         = local.dynamodb_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

## Create The IAM policy

resource "aws_iam_policy" "terraform_state" {

  name = local.policy_name

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : "s3:ListBucket",
        "Resource" : "${aws_s3_bucket.terraform_state.arn}"
      },
      {
        "Effect" : "Allow",
        "Action" : ["s3:GetObject", "s3:PutObject"],
        "Resource" : "${aws_s3_bucket.terraform_state.arn}/*"
      },
      {
        "Effect" : "Allow",
        "Action" : [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:DeleteItem"
        ],
        "Resource" : "${aws_dynamodb_table.terraform_lock.arn}"
      }
    ]
  })
}

data "template_file" "terraform_backend_config" {
  template = file(local.terraform_backend_config_template_file)

  vars = {
    region               = var.region
    bucket               = aws_s3_bucket.terraform_state.id
    dynamodb_table       = aws_dynamodb_table.terraform_lock.name
    encrypt              = "true"
    terraform_version    = var.terraform_version
    terraform_state_file = var.terraform_state_file
  }
}

resource "local_file" "terraform_backend_config" {
  content         = data.template_file.terraform_backend_config.rendered
  filename        = "terraform.tf"
  file_permission = "0644"
}