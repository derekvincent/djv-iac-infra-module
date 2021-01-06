locals {
  # cgw_name = join("-", [var.namespace, var.name, var.environment, "cgw"])
  # vpn_name = join("-", [var.namespace, var.name, var.environment, "vpn"])

  tag_name_env      = join(":", [var.namespace, "environment"])
  tag_name_customer = join(":", [var.namespace, "customer"])
  common_tags = map(
    local.tag_name_env, var.environment,
    local.tag_name_customer, var.customer
  )
}

resource "aws_route" "default" {
  count                     = length(var.destination_cidr_blocks)
  route_table_id            = var.route_table_id
  destination_cidr_block    = var.destination_cidr_blocks[count.index]
  transit_gateway_id        = var.transit_gateway_id
  vpc_peering_connection_id = var.vpc_peering_id
}