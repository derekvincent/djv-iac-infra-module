## Common Tags defined in Labels.tf
locals {
  ## Var if the type is private - used with count
  is_private = var.type == "private" ? 1 : 0
  ## List of private subnets when the type is private - used when needing to 
  ## iterate over list of subnets
  private_subnets = var.type == "private" ? var.private_subnets : {}
  ## Var if the type is private and the enble_nat_gateway is true - used with count
  ngw_id_set = var.type == "private" && var.enable_nat_gateway ? 1 : 0
}

## Creates the base subnets in each AZ within the specified VPC
resource "aws_subnet" "private" {
  for_each          = local.private_subnets
  vpc_id            = var.vpc_id
  availability_zone = each.key
  cidr_block        = each.value

  tags = merge(
    local.common_tags,
    map(
      "Name", join("-", [
        var.namespace,
        var.name,
        var.environment,
        "priv",
        substr(each.key, length(each.key) - 2, 2),
        "sn"
      ])
    )
  )
}


## Create a single route table for each set of subnets. 
resource "aws_route_table" "private" {
  count  = local.is_private
  vpc_id = var.vpc_id

  tags = merge(
    local.common_tags,
    map(
      "Name", join("-", [
        var.namespace,
        var.name,
        var.environment,
        "priv",
        "sn",
      "rtb"])
    )
  )
}

## Add a detault route to the NAT GW for internet access
resource "aws_route" "private" {
  count                  = local.ngw_id_set
  route_table_id         = aws_route_table.private[0].id
  nat_gateway_id         = var.ngw_id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "private" {
  for_each       = local.private_subnets
  subnet_id      = aws_subnet.private[each.key].id
  route_table_id = aws_route_table.private[0].id
}

# resource "aws_route_table" "private" {
#     for_each = local.private_subnets
#     vpc_id   = var.vpc_id

#     tags = merge(
#         local.common_tags,
#         map(
#             "Name", join("-", [
#                 var.namespace, 
#                 var.name, 
#                 var.environment, 
#                 "priv", 
#                 substr(each.key, length(each.key)-2, 2), 
#                 "rtb"])
#         )
#     )
# }

# resource "aws_route" "private" {
#   for_each               = local.private_subnets
#   route_table_id         = aws_route_table.private[each.key].id
#   nat_gateway_id         = var.ngw_id
#   destination_cidr_block = "0.0.0.0/0"
# }

# resource "aws_route_table_association" "private" {
#     for_each        = local.private_subnets
#     subnet_id       = aws_subnet.private[each.key].id
#     route_table_id  = aws_route_table.private[each.key].id
# }