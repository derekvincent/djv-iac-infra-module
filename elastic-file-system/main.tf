locals {
  efs_random_prefix = join("", [join("-", [var.name, var.environment, var.detail_name]), "-"])
  efs_name          = join("-", [var.namespace, var.name, var.environment, var.detail_name, "fs"])
  efs_sg_name       = join("-", [local.efs_name, "sg"])

  tag_name_env         = join(":", [var.namespace, "environment"])
  tag_name_customer    = join(":", [var.namespace, "customer"])
  tag_name_description = join(":", [var.namespace, "description"])
  common_tags = map(
    local.tag_name_env, var.environment,
    local.tag_name_customer, var.customer,
    local.tag_name_description, var.description
  )
}

resource "random_id" "creation_token" {
  byte_length = 8
  prefix      = local.efs_random_prefix
}

resource "aws_efs_file_system" "default" {
  creation_token   = random_id.creation_token.hex
  performance_mode = "generalPurpose"
  throughput_mode  = "bursting"
  encrypted        = "true"

  dynamic "lifecycle_policy" {
    for_each = var.transition_to_ia == "" ? [] : [1]
    content {
      transition_to_ia = var.transition_to_ia
    }
  }

  tags = merge(
    local.common_tags,
    map(
      "Name", local.efs_name,
      join(":", [var.namespace, "creation-token"]), random_id.creation_token.hex
    )
  )
}

resource "aws_efs_file_system_policy" "policy" {
  file_system_id = aws_efs_file_system.default.id

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Id" : "efs-policy-${local.efs_name}",
    "Statement" : [
      {
        "Sid" : "efs-statement-${local.efs_name}-1",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "*"
        },
        "Action" : [
          "elasticfilesystem:ClientMount",
          "elasticfilesystem:ClientRootAccess",
          "elasticfilesystem:ClientWrite"
        ],
        "Resource" : "${aws_efs_file_system.default.arn}"
      },
      {
        "Sid" : "efs-statement-${local.efs_name}-2",
        "Effect" : "Deny",
        "Principal" : {
          "AWS" : "*"
        },
        "Action" : "*",
        "Resource" : "${aws_efs_file_system.default.arn}",
        "Condition" : {
          "Bool" : {
            "aws:SecureTransport" : "false"
          }
        }
      }
    ]
  })

}

resource "aws_efs_mount_target" "default" {
  count = length(var.mount_subnets)

  file_system_id  = aws_efs_file_system.default.id
  subnet_id       = element(var.mount_subnets, count.index)
  security_groups = [aws_security_group.mount_target.id]
}

resource "aws_security_group" "mount_target" {
  name        = local.efs_sg_name
  description = "Allow traffic from instances using ${var.name}-ec2."
  vpc_id      = var.vpc_id

  tags = merge(
    local.common_tags,
    map(
      "Name", local.efs_sg_name
    )
  )
}

resource "aws_efs_access_point" "default" {
  for_each       = var.access_points
  file_system_id = aws_efs_file_system.default.id
  root_directory {
    path = lookup(each.value, "root_directory")

    creation_info {
      owner_uid   = lookup(each.value, "owner_uid", 0)
      owner_gid   = lookup(each.value, "owner_gid", 1001)
      permissions = lookup(each.value, "permissions", 0775)
    }
  }

  tags = merge(
    local.common_tags,
    map(
      "Name", join("-", [var.namespace, var.name, var.environment, each.key, "fsap"])
    )
  )
}

resource "aws_security_group_rule" "nfs_ingress" {
  description       = "Allow NFS traffic into mount target from EC2"
  type              = "ingress"
  from_port         = 2049
  to_port           = 2049
  protocol          = "tcp"
  cidr_blocks       = var.security_group_cidrs
  prefix_list_ids   = var.security_group_prefix_list_ids
  security_group_id = aws_security_group.mount_target.id

}