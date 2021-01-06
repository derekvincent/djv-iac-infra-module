locals {
  vpc_name  = join("-", [var.namespace, var.name, var.environment, "vpc"])
  igw_name  = join("-", [var.namespace, var.name, var.environment, "igw"])
  dsg_name  = join("-", [var.namespace, var.name, var.environment, "sg"])
  nacl_name = join("-", [var.namespace, var.name, var.environment, "nacl"])
  rt_name   = join("-", [var.namespace, var.name, var.environment, "rtb"])
  dopt_name = join("-", [var.namespace, var.name, var.environment, "dopt"])

  tag_name_env      = join(":", [var.namespace, "environment"])
  tag_name_customer = join(":", [var.namespace, "customer"])
  common_tags = map(
    local.tag_name_env, var.environment,
    local.tag_name_customer, var.customer
  )
}

resource "aws_vpc" "default" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = var.enable_dns_hostname
  enable_dns_support   = var.enable_dns_support

  tags = merge(
    local.common_tags,
    map(
      "Name", local.vpc_name
    )
  )
}

resource "aws_default_security_group" "default" {
  #name   = local.dsg_name
  #description = join(": ", ["Default Security Group for vpc", local.vpc_name])
  vpc_id = join("", aws_vpc.default.*.id)
  tags = merge(
    local.common_tags,
    map(
      "Name", local.dsg_name
    )
  )
}

resource "aws_default_route_table" "default" {
  default_route_table_id = aws_vpc.default.default_route_table_id
  tags = merge(
    local.common_tags,
    map(
      "Name", local.rt_name
    )
  )
}

resource "aws_default_network_acl" "default" {
  default_network_acl_id = aws_vpc.default.default_network_acl_id
  ## Need to pass in rules... 
  ## Currently allow everything in and out... 
  ingress {
    protocol = -1
    rule_no  = 100
    action   = "allow"
    #cidr_block = aws_vpc.default.cidr_block
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = merge(
    local.common_tags,
    map(
      "Name", local.nacl_name
    )
  )

  lifecycle {
    ignore_changes = [subnet_ids]
  }
}

## Create the a Internet Gateway for the VPC 
## Creation is selectable via the enable_internet_gateway varibale 
## May want to look at allowing filter options to be passed in  
resource "aws_internet_gateway" "default" {
  count  = var.enable_internet_gateway ? 1 : 0
  vpc_id = join("", aws_vpc.default.*.id)
  tags = merge(
    local.common_tags,
    map(
      "Name", local.igw_name
    )
  )
}

## Create the Named DHCP Option set 
## Input: DNS Name and Servers
## Extened later to do addtional options (NETBios, NTP Server) as required. 
##  ntp_servers          = ["127.0.0.1"] --> List 
##  netbios_name_servers = ["127.0.0.1"] --> List
##  netbios_node_type    = 2             --> Number 
resource "aws_vpc_dhcp_options" "dns_resolver" {
  domain_name         = var.dns_domain_name
  domain_name_servers = var.dns_server_list

  tags = merge(
    local.common_tags,
    map(
      "Name", local.dopt_name
    )
  )
}

## Create the Associaiton Between the VPC and the DHCP Options
resource "aws_vpc_dhcp_options_association" "dns_resolver" {
  vpc_id          = aws_vpc.default.id
  dhcp_options_id = aws_vpc_dhcp_options.dns_resolver.id
}