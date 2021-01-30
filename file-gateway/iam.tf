##
## Create EC2 Instance roles, attach standard policies and profiles. 
##

resource "aws_iam_instance_profile" "file_gateway" {
  name = join("-", [local.instance_name, "role"])
  role = aws_iam_role.file_gateway.name
}

## Create a Role for the EC2 instance
resource "aws_iam_role" "file_gateway" {
  name = join("-", [local.instance_name, "role"])

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : {
      "Effect" : "Allow",
      "Principal" : { "Service" : "ec2.amazonaws.com" },
      "Action" : "sts:AssumeRole"
    }
  })

  tags = merge(
    local.common_tags,
    map(
      "Name", join("-", [local.instance_name, "role"]),
    )
  )
}

# Assign the SSM policy to the role
resource "aws_iam_role_policy_attachment" "systems_manager" {
  role       = aws_iam_role.file_gateway.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

## Assign the CloudWatch policy to the role
resource "aws_iam_role_policy_attachment" "cloudwatch" {
  role       = aws_iam_role.file_gateway.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

## Attach the inline policy to the role. 
resource "aws_iam_role_policy" "s3-bucket-policy" {
  name   = join("-", [local.instance_name, "s3-policy"])
  role   = aws_iam_role.file_gateway.name
  policy = data.aws_iam_policy_document.s3_bucket_policy_document.json
}

## Create the Inline policy 
data "aws_iam_policy_document" "s3_bucket_policy_document" {

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
      "s3:DeleteObject"
    ]

    resources = flatten([for arn in var.bucket_arns :
      [format("%s", arn), format("%s/*", arn)]
    ])
  }
}