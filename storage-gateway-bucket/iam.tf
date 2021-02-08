data "aws_iam_policy_document" "policy_document" {
  statement {
    actions = [
      "s3:GetAccelerateConfiguration",
      "s3:GetBucketLocation",
      "s3:GetBucketVersioning",
      "s3:ListBucket",
      "s3:ListBucketVersions",
      "s3:ListBucketMultipartUploads",
    ]

    resources = [
      aws_s3_bucket.storage_gateway.arn,
    ]

    effect = "Allow"
  }

  statement {
    actions = [
      "s3:AbortMultipartUpload",
      "s3:DeleteObject",
      "s3:DeleteObjectVersion",
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:ListMultipartUploadParts",
      "s3:PutObject",
    ]

    resources = [
      "${aws_s3_bucket.storage_gateway.arn}/*",
    ]

    effect = "Allow"
  }
}

data "aws_iam_policy_document" "assume_role_policy_document" {
  statement {
    effect = "Allow"

    principals {
      identifiers = [
        "storagegateway.amazonaws.com",
      ]

      type = "Service"
    }

    actions = [
      "sts:AssumeRole",
    ]
  }
}

resource "aws_iam_role" "role" {
  name               = local.role_name
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy_document.json
  description        = "IAM role for file gateway"
}

resource "aws_iam_policy" "iam_policy" {
  name   = local.policy_name
  policy = data.aws_iam_policy_document.policy_document.json
}

resource "aws_iam_role_policy_attachment" "policy_attachment" {
  role       = aws_iam_role.role.id
  policy_arn = aws_iam_policy.iam_policy.arn
}