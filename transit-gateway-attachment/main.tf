locals {
  twg_attach_name = join("-", [data.aws_vpc.default.tags["Name"], "tgw-attach"])

  tag_name_env      = join(":", [var.namespace, "environment"])
  tag_name_customer = join(":", [var.namespace, "customer"])
  common_tags = map(
    local.tag_name_env, var.environment,
    local.tag_name_customer, var.customer
  )
}


resource "aws_ec2_transit_gateway_vpc_attachment" "default" {
  subnet_ids         = var.subnet_ids
  transit_gateway_id = var.transit_gateway_id
  vpc_id             = var.vpc_id

  tags = merge(
    local.common_tags,
    map(
      "Name", local.twg_attach_name
    )
  )
}

## Fetch the VPC and VPC route tables 
data "aws_vpc" "default" {
  id = var.vpc_id
}

# data "aws_route_tables" "default" {
#     vpc_id = data.aws_vpc.default.id
# } 

## Add route to each route table for the destination CIDR to the TGW
resource "aws_route" "to_tgw" {
  count                  = length(var.route_table_ids)
  route_table_id         = var.route_table_ids[count.index]
  destination_cidr_block = var.destination_cidr
  transit_gateway_id     = var.transit_gateway_id

  depends_on = [
    aws_ec2_transit_gateway_vpc_attachment.default,
  ]
}