locals {
  tag_name_env      = join(":", [var.namespace, "environment"])
  tag_name_customer = join(":", [var.namespace, "customer"])
  common_tags = map(
    local.tag_name_env, var.environment,
    local.tag_name_customer, var.customer
  )
}

resource "aws_vpc_peering_connection" "default" {
  count       = var.enabled ? 1 : 0
  vpc_id      = join("", data.aws_vpc.requestor.*.id)
  peer_vpc_id = join("", data.aws_vpc.acceptor.*.id)

  auto_accept = var.auto_accept

  accepter {
    allow_remote_vpc_dns_resolution = var.acceptor_allow_remote_vpc_dns_resolution
  }

  requester {
    allow_remote_vpc_dns_resolution = var.requestor_allow_remote_vpc_dns_resolution
  }

  tags = merge(
    local.common_tags,
    map(
      "Name", join("-", [
        join("-", [
          var.namespace,
          var.name,
          var.environment,
          "vpc"
        ]),
        data.aws_vpc.acceptor[count.index].tags.Name,
        "pcx"
      ])
    )
  )

  timeouts {
    create = var.create_timeout
    update = var.update_timeout
    delete = var.delete_timeout
  }
}

data "aws_vpc" "requestor" {
  count = var.enabled ? 1 : 0
  id    = var.requestor_vpc_id
  tags  = var.requestor_vpc_tags
}

# Lookup acceptor VPC so that we can reference the CIDR
data "aws_vpc" "acceptor" {
  count = var.enabled ? 1 : 0
  id    = var.acceptor_vpc_id
  tags  = { Name = var.acceptor_vpc_name_tag }
}

## Peering Routing  

## Consider this 
## Pass in the Requestor (QA in test case) public and private subnet route table id
## as variables and have a "aws_route_tables" "requestor_public" and 
## "aws_route_tables" "requestor_private"  sections. 
## Since the assumption is that the acceptor VPC/Subnet exists we can draw the same 
## data from the data blocks.
##
## Not perfect but an issue for testing in the AM. 

### Get routing tables for each VPC  
data "aws_route_tables" "requestor" {
  count  = var.enabled ? 1 : 0
  vpc_id = join("", data.aws_vpc.requestor.*.id)
}

data "aws_route_tables" "acceptor" {
  count  = var.enabled ? 1 : 0
  vpc_id = join("", data.aws_vpc.acceptor.*.id)
}

### Create routes from requestor to acceptor 
#resource "aws_route" "requestor" {
#   count                     = var.enabled ? length(distinct(sort(data.aws_route_tables.requestor.0.ids))) * length(data.aws_vpc.acceptor.0.cidr_block_associations) : 0
#   route_table_id            = element(distinct(sort(data.aws_route_tables.requestor.0.ids)), ceil(count.index / length(data.aws_vpc.acceptor.0.cidr_block_associations)))
#   destination_cidr_block    = data.aws_vpc.acceptor.0.cidr_block_associations[count.index % length(data.aws_vpc.acceptor.0.cidr_block_associations)]["cidr_block"]
#   vpc_peering_connection_id = join("", aws_vpc_peering_connection.default.*.id)
#   depends_on                = [data.aws_route_tables.requestor, aws_vpc_peering_connection.default]
#    count                     = var.enabled ? length(data.aws_route_tables.requestor.ids) : 0 
#    route_table_id            = data.aws_route_tables.requestor.ids[count.index]
#    route_table_id            = data.aws_vpc.requestor.0.main_route_table_id
#    destination_cidr_block    = data.aws_vpc.acceptor.0.cidr_block
#    vpc_peering_connection_id = join("", aws_vpc_peering_connection.default.*.id)
#    depends_on                = [data.aws_route_tables.requestor, aws_vpc_peering_connection.default]
#}

resource "aws_route" "requestor_main" {
  count                     = var.enabled ? 1 : 0
  route_table_id            = data.aws_vpc.requestor.0.main_route_table_id
  destination_cidr_block    = data.aws_vpc.acceptor.0.cidr_block
  vpc_peering_connection_id = join("", aws_vpc_peering_connection.default.*.id)
}

resource "aws_route" "requestor_private" {
  count                     = var.enabled ? 1 : 0
  route_table_id            = var.requestor_private_route_table_id
  destination_cidr_block    = data.aws_vpc.acceptor.0.cidr_block
  vpc_peering_connection_id = join("", aws_vpc_peering_connection.default.*.id)
}

resource "aws_route" "requestor_public" {
  count                     = var.enabled ? 1 : 0
  route_table_id            = var.requestor_public_route_table_id
  destination_cidr_block    = data.aws_vpc.acceptor.0.cidr_block
  vpc_peering_connection_id = join("", aws_vpc_peering_connection.default.*.id)
}

# Create routes from acceptor to requestor
resource "aws_route" "acceptor" {
  count                     = var.enabled ? length(data.aws_route_tables.acceptor.0.ids) : 0
  route_table_id            = element(tolist(data.aws_route_tables.acceptor.0.ids), count.index)
  depends_on                = [data.aws_route_tables.acceptor, aws_vpc_peering_connection.default]
  destination_cidr_block    = data.aws_vpc.requestor.0.cidr_block
  vpc_peering_connection_id = join("", aws_vpc_peering_connection.default.*.id)
}

