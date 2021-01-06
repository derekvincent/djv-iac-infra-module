locals {
  zone_name = join("-", [var.namespace, var.name, var.environment, replace(var.dns_domain_name, ".", "-"), "r53", "zone"])
  #policy_name = join("-", [var.namespace, var.name, var.environment, "private-zone", "policy"])
  policy_name = join("-", [var.namespace, var.name, var.environment, var.dns_domain_name, "policy"])

  tag_name_env         = join(":", [var.namespace, "environment"])
  tag_name_customer    = join(":", [var.namespace, "customer"])
  tag_name_application = join(":", [var.namespace, "application"])
  common_tags = map(
    local.tag_name_env, var.environment,
    local.tag_name_customer, var.customer,
    local.tag_name_application, var.name
  )
}

resource "aws_route53_zone" "private" {
  name = var.dns_domain_name

  vpc {
    vpc_id = var.vpc_id
  }

  tags = merge(
    local.common_tags,
    map(
      "Name", local.zone_name
    )
  )

  lifecycle {
    ignore_changes = [
      ## Ignore changes to the VPC since they are also set by the other landscapes (ie: dev,qa,prd)
      ## If the main VPC were the change the expectation is a full rebuild. 
      vpc,
    ]
  }
}

## Create The IAM policy

resource "aws_iam_policy" "private_zone" {
  name = local.policy_name
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Sid" : "PrivateZone0",
          "Effect" : "Allow",
          "Action" : [
            "route53:DeleteVPCAssociationAuthorization",
            "route53:ListTagsForResources",
            "route53:GetChange",
            "route53:GetHostedZone",
            "route53:ChangeResourceRecordSets",
            "route53:ListVPCAssociationAuthorizations",
            "route53:AssociateVPCWithHostedZone",
            "route53:CreateVPCAssociationAuthorization",
            "route53:ListTagsForResource"
          ],
          "Resource" : [
            "${join("/", ["arn:aws:route53:::hostedzone", aws_route53_zone.private.zone_id])}",
            "arn:aws:route53:::change/*"
          ]

        },
        {
          "Sid" : "PrivateZone2",
          "Effect" : "Allow",
          "Action" : "route53:ListResourceRecordSets",
          "Resource" : "${join("/", ["arn:aws:route53:::hostedzone", aws_route53_zone.private.zone_id])}",
        },
        {
          "Sid" : "PrivateZone1",
          "Effect" : "Allow",
          "Action" : [
            "ec2:DescribeVpcs",
            "route53:ListHostedZones",
            "route53:ListHostedZonesByName"
          ],
          "Resource" : "*"
        }
      ]
    }
  )
}