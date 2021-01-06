## Common Tags defined in Labels.tf
locals {
  ## Var if the type is public - used with count
  is_public = var.type == "public" ? 1 : 0
  ## List of public subnets when the type is public - used when needing to 
  ## iterate over list of subnets
  public_subnets = var.type == "public" ? var.public_subnets : {}
  ## Var if the type is public and enable_nat_gateway is set 
  ngw_set = var.enable_nat_gateway && var.type == "public" ? 1 : 0

}

## Creates the base subnets in each AZ within the specified VPC
resource "aws_subnet" "public" {
  for_each          = local.public_subnets
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
        "pub",
        substr(each.key, length(each.key) - 2, 2),
        "sn"
      ])
    )
  )
}

## Create a single route table for each set of subnets. 
resource "aws_route_table" "public" {
  count  = local.is_public
  vpc_id = var.vpc_id

  tags = merge(
    local.common_tags,
    map(
      "Name", join("-", [
        var.namespace,
        var.name,
        var.environment,
        "pub",
        "sn",
        "rtb"
      ])
    )
  )
}

## Add a detault route to the Internet GW for internet access
resource "aws_route" "public" {
  count                  = local.is_public
  route_table_id         = aws_route_table.public[0].id
  gateway_id             = var.igw_id
  destination_cidr_block = "0.0.0.0/0"
}

## Add an association for the subnets to the pubic subnet route table 
resource "aws_route_table_association" "public" {
  for_each       = local.public_subnets
  subnet_id      = aws_subnet.public[each.key].id
  route_table_id = aws_route_table.public[0].id
}
# resource "aws_route_table" "public" {
#     for_each = local.public_subnets
#     vpc_id   = var.vpc_id

#     tags = merge(
#         local.common_tags,
#         map(
#             "Name", join("-", [
#                 var.namespace, 
#                 var.name, 
#                 var.environment, 
#                 "pub", 
#                 substr(each.key, length(each.key)-2, 2), 
#                 "rtb"
#             ])
#         )
#     )
# }

# resource "aws_route" "public" {
#   for_each               = local.public_subnets
#   route_table_id         = aws_route_table.public[each.key].id
#   gateway_id             = var.igw_id
#   destination_cidr_block = "0.0.0.0/0"
# }

# resource "aws_route_table_association" "public" {
#     for_each        = local.public_subnets
#     subnet_id       = aws_subnet.public[each.key].id
#     route_table_id  = aws_route_table.public[each.key].id
# }

## Opinionated Design: If provisiong a NAT gateway always in the first public subnet.

## Create the NAT Gateway Elastic IP 
resource "aws_eip" "nat_gw_eip" {
  count = local.ngw_set
  vpc   = true

  tags = merge(
    local.common_tags,
    map(
      "Name", join("-", [
        aws_subnet.public[keys(aws_subnet.public)[0]].tags.Name,
        "nat-gw",
        "eip"
      ])
    )
  )
  lifecycle {
    create_before_destroy = true
  }
}

## Create the NAT Gateway 
resource "aws_nat_gateway" "default" {
  count         = local.ngw_set
  allocation_id = join("", aws_eip.nat_gw_eip.*.id)
  subnet_id     = aws_subnet.public[keys(aws_subnet.public)[0]].id

  tags = merge(
    local.common_tags,
    map(
      "Name", join("-", [
        aws_subnet.public[keys(aws_subnet.public)[0]].tags.Name,
        "nat-gw"
      ])
    )
  )
  lifecycle {
    create_before_destroy = true
  }
}
