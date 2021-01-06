locals {
  twg_name = join("-", [var.namespace, var.name, var.environment, "tgw"])
  rtb_name = join("-", [local.twg_name, "rtb"])
  vpc_name = join("-", [var.namespace, var.name, var.environment, "vpc", "tgw", "attach"])
  ram_name = join("-", [local.twg_name, "ram"])

  tag_name_env      = join(":", [var.namespace, "environment"])
  tag_name_customer = join(":", [var.namespace, "customer"])
  common_tags = map(
    local.tag_name_env, var.environment,
    local.tag_name_customer, var.customer
  )
}

resource "aws_ec2_transit_gateway" "default" {

  count = var.create_tgw ? 1 : 0

  description                     = "Test TGW" #coalesce(var.description, var.name)
  amazon_side_asn                 = var.amazon_side_asn
  default_route_table_association = var.enable_default_route_table_association ? "enable" : "disable"
  default_route_table_propagation = var.enable_default_route_table_propagation ? "enable" : "disable"
  auto_accept_shared_attachments  = var.enable_auto_accept_shared_attachments ? "enable" : "disable"
  vpn_ecmp_support                = var.enable_vpn_ecmp_support ? "enable" : "disable"
  dns_support                     = var.enable_dns_support ? "enable" : "disable"

  tags = merge(
    local.common_tags,
    map(
      "Name", local.twg_name
    )
  )
}

resource "aws_ec2_transit_gateway_vpc_attachment" "example" {
  subnet_ids         = var.subnet_ids
  transit_gateway_id = aws_ec2_transit_gateway.default[0].id
  vpc_id             = var.vpc_id

  tags = merge(
    local.common_tags,
    map(
      "Name", local.vpc_name
    )
  )
}

# ## Set the Routes for the Tgw attachment
# ## Fetch the VPC and VPC route tables 
data "aws_vpc" "default" {
  id = var.vpc_id
}

# data "aws_route_tables" "default" {
#     vpc_id = data.aws_vpc.default.id
# } 

## Add route to each route table for the destination CIDR to the TGW
resource "aws_route" "to_tgw" {
  count                  = length(var.vpc_route_table_ids)
  route_table_id         = var.vpc_route_table_ids[count.index]
  destination_cidr_block = var.destination_cidr
  transit_gateway_id     = aws_ec2_transit_gateway.default[0].id
}

## 
## Get the AWS organization associated with the master account.
##
data "aws_organizations_organization" "default" {}

##
## Create the Reasource Access Manager resource share
##
resource "aws_ram_resource_share" "default" {
  name                      = local.ram_name
  allow_external_principals = false

  tags = merge(
    local.common_tags,
    map(
      "Name", local.ram_name
    )
  )
}

##
## Assign the Organization as the principal
##
resource "aws_ram_principal_association" "example" {
  principal          = data.aws_organizations_organization.default.arn
  resource_share_arn = aws_ram_resource_share.default.arn
}

##
## Assign the Transit Gateway created as the resource
##
resource "aws_ram_resource_association" "default" {
  resource_arn       = aws_ec2_transit_gateway.default[0].arn
  resource_share_arn = aws_ram_resource_share.default.arn
}