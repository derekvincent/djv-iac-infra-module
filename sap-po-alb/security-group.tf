resource "aws_security_group" "lb" {
  name        = local.sg_name
  description = "File Gateway Security Group"
  vpc_id      = var.vpc_id

  tags = merge(
    local.common_tags,
    map(
      "Name", local.sg_name
    )
  )
}

resource "aws_security_group_rule" "ingress" {
  for_each          = var.lb_ingress_map
  type              = "ingress"
  from_port         = lookup(each.value, "from_port")
  to_port           = lookup(each.value, "to_port")
  protocol          = lookup(each.value, "protocol")
  cidr_blocks       = lookup(each.value, "cidr_blocks", null)
  description       = lookup(each.value, "description", "")
  security_group_id = aws_security_group.lb.id
}

resource "aws_security_group_rule" "egress" {
  for_each          = var.lb_egress_map
  type              = "egress"
  from_port         = lookup(each.value, "from_port")
  to_port           = lookup(each.value, "to_port")
  protocol          = lookup(each.value, "protocol")
  cidr_blocks       = lookup(each.value, "cidr_blocks", null)
  description       = lookup(each.value, "description", "")
  security_group_id = aws_security_group.lb.id
}