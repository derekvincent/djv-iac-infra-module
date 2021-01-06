locals {
  rslvr_name     = join("-", [var.namespace, var.name, var.environment, "rslvr"])
  rslvr_out_name = join("-", [local.rslvr_name, "out"])
  rslvr_in_name  = join("-", [local.rslvr_name, "in"])
  rslvr_sg_name  = join("-", [local.rslvr_name, "sg"])
  rslvr_ram_name = join("-", [local.rslvr_name, "ram"])


  ## Iterate over the domain_server_map ( "fortisontario.com" : ["192.168.1.25", "192.168.5.25"])
  ## and return a unique single server list 
  dns_server_list = distinct(flatten([for dns_name, servers in var.forward_rules_map :
    servers
  ]))

  ## Use the list generated above and 
  dns_cidr_list = [for server in local.dns_server_list :
    join("/", [server, "32"])
  ]

  tag_name_env      = join(":", [var.namespace, "environment"])
  tag_name_customer = join(":", [var.namespace, "customer"])
  common_tags = map(
    local.tag_name_env, var.environment,
    local.tag_name_customer, var.customer
  )
}

## Creates a Security group (if enabled) to be assigned to the 
resource "aws_security_group" "resolver_endpoint" {

  count       = var.create_security_group ? 1 : 0
  name        = local.rslvr_sg_name
  description = join(" ", [var.namespace, var.name, var.environment, "Route 53 Resolver Security Group"])
  vpc_id      = var.vpc_id


  ingress {
    description = "DNS (UDP) from On-Premise Server"
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    cidr_blocks = local.dns_cidr_list
  }

  ingress {
    description = "DNS (TCP) from On-Premise Server"
    from_port   = 53
    to_port     = 53
    protocol    = "tcp"
    cidr_blocks = local.dns_cidr_list
  }

  egress {
    description = "DNS (UDP) to On-Premise Server"
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    cidr_blocks = local.dns_cidr_list
  }

  egress {
    description = "DNS (TCP) to On-Premise Server"
    from_port   = 53
    to_port     = 53
    protocol    = "tcp"
    cidr_blocks = local.dns_cidr_list
  }

  tags = merge(
    local.common_tags,
    map(
      "Name", local.rslvr_sg_name
    )
  )
}


## Create the out bound resolver 
resource "aws_route53_resolver_endpoint" "outbound" {
  count     = var.enable_outbound_resolver ? 1 : 0
  name      = local.rslvr_out_name
  direction = "OUTBOUND"

  security_group_ids = var.create_security_group ? tolist(aws_security_group.resolver_endpoint.*.id) : var.security_group_ids

  ip_address {
    subnet_id = var.out_subnet_1_id
    ip        = var.out_ip1_address
  }

  ip_address {
    subnet_id = var.out_subnet_2_id
    ip        = var.out_ip2_address
  }

  tags = merge(
    local.common_tags,
    map(
      "Name", local.rslvr_out_name
    )
  )
}

## Create the inbound resolver 
resource "aws_route53_resolver_endpoint" "inbound" {
  count     = var.enable_inbound_resolver ? 1 : 0
  name      = local.rslvr_in_name
  direction = "INBOUND"

  security_group_ids = var.create_security_group ? tolist(aws_security_group.resolver_endpoint.*.id) : var.security_group_ids

  ip_address {
    subnet_id = var.in_subnet_1_id
    ip        = var.in_ip1_address
  }

  ip_address {
    subnet_id = var.in_subnet_2_id
    ip        = var.in_ip2_address
  }

  tags = merge(
    local.common_tags,
    map(
      "Name", local.rslvr_in_name
    )
  )
}

## Create the Forward Resolver Rules
resource "aws_route53_resolver_rule" "forward" {
  for_each             = var.forward_rules_map
  domain_name          = each.key
  name                 = join("-", [var.namespace, replace(each.key, ".", "-"), "rslvr", "rr"])
  rule_type            = "FORWARD"
  resolver_endpoint_id = join("", aws_route53_resolver_endpoint.outbound.*.id)

  dynamic "target_ip" {
    for_each = each.value
    content {
      ip = target_ip.value
    }
  }

  tags = merge(
    local.common_tags,
    map(
      "Name", join("-", [var.namespace, replace(each.key, ".", "-"), "rslvr", "rr"])
    )
  )
}

resource "aws_route53_resolver_rule_association" "default" {
  for_each         = aws_route53_resolver_rule.forward
  resolver_rule_id = each.value["id"]
  vpc_id           = var.vpc_id

  depends_on = [
    aws_route53_resolver_rule.forward,
  ]
}

## 
## Get the AWS organization associated with the master account.
##
data "aws_organizations_organization" "default" {}

##
## Create the Reasource Access Manager resource share
##
resource "aws_ram_resource_share" "default" {
  name                      = local.rslvr_ram_name
  allow_external_principals = false

  tags = merge(
    local.common_tags,
    map(
      "Name", local.rslvr_ram_name
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
  for_each           = aws_route53_resolver_rule.forward
  resource_arn       = each.value["arn"]
  resource_share_arn = aws_ram_resource_share.default.arn
}