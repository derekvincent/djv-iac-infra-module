##

locals {
  vpg_name = join("-", [var.namespace, var.name, var.environment, "dx", var.amazon_side_asn, "vgw"])

  tag_name_env      = join(":", [var.namespace, "environment"])
  tag_name_customer = join(":", [var.namespace, "customer"])
  common_tags = map(
    local.tag_name_env, var.environment,
    local.tag_name_customer, var.customer
  )
}

data "aws_vpc" "selected" {
  id = var.vpc_id
}

resource "aws_vpn_gateway" "dx_vgw" {
  vpc_id          = var.vpc_id
  amazon_side_asn = var.amazon_side_asn

  tags = merge(
    local.common_tags,
    map(
      "Name", local.twg_name
    )
  )
}

resource "aws_vpn_gateway_route_propagation" "default" {
  count          = length(var.route_table_ids)
  vpn_gateway_id = aws_vpn_gateway.dx_vgw.id
  route_table_id = var.route_table_ids[index]
}

resource "aws_dx_gateway_association_proposal" "default" {
  dx_gateway_id               = var.dx_gateway_id
  dx_gateway_owner_account_id = var.dx_gateway_account_id
  associated_gateway_id       = aws_vpn_gateway.dx_vgw.id
  allowed_prefixes            = [data.vpc_id.selected.cidr_block]
}
