locals {
  cgw_name = join("-", [var.namespace, var.name, var.environment, var.target, "cgw"])
  vpn_name = join("-", [var.namespace, var.name, var.environment, var.target, "vpn"])

  tag_name_env      = join(":", [var.namespace, "environment"])
  tag_name_customer = join(":", [var.namespace, "customer"])
  common_tags = map(
    local.tag_name_env, var.environment,
    local.tag_name_customer, var.customer
  )
}


resource "aws_customer_gateway" "default" {
  bgp_asn    = var.bgp_asn
  ip_address = var.ip_address
  type       = "ipsec.1"

  tags = merge(
    local.common_tags,
    map(
      "Name", local.cgw_name
    )
  )
}

resource "aws_vpn_connection" "transit_gateway" {
  customer_gateway_id = aws_customer_gateway.default.id
  transit_gateway_id  = var.transit_gateway_id
  type                = aws_customer_gateway.default.type
  static_routes_only  = var.static_routes_only

  tunnel1_ike_versions                 = var.tunnel1_ike_versions
  tunnel1_phase1_dh_group_numbers      = var.tunnel1_phase1_dh_group_numbers
  tunnel1_phase1_encryption_algorithms = var.tunnel1_phase1_encryption_algorithms
  tunnel1_phase1_integrity_algorithms  = var.tunnel1_phase1_integrity_algorithms
  tunnel1_phase2_dh_group_numbers      = var.tunnel1_phase2_dh_group_numbers
  tunnel1_phase2_encryption_algorithms = var.tunnel1_phase2_encryption_algorithms
  tunnel1_phase2_integrity_algorithms  = var.tunnel1_phase2_integrity_algorithms
  tunnel2_ike_versions                 = var.tunnel2_ike_versions
  tunnel2_phase1_dh_group_numbers      = var.tunnel2_phase1_dh_group_numbers
  tunnel2_phase1_encryption_algorithms = var.tunnel2_phase1_encryption_algorithms
  tunnel2_phase1_integrity_algorithms  = var.tunnel2_phase1_integrity_algorithms
  tunnel2_phase2_dh_group_numbers      = var.tunnel2_phase2_dh_group_numbers
  tunnel2_phase2_encryption_algorithms = var.tunnel2_phase2_encryption_algorithms
  tunnel2_phase2_integrity_algorithms  = var.tunnel2_phase2_integrity_algorithms

  tags = merge(
    local.common_tags,
    map(
      "Name", local.cgw_name
    )
  )


}

## Tag updates 
# resource "null_resource" "ManagedADTags" {
#     provisioner "local-exec" {
#         command = "aws --profile ${var.profile} --region ${var.region} ec2 create-tags -- 
#         resources ${aws_directory_service_directory.NewDS.security_group_id} --tags 
#         Key=Name,Value=${format("${local.security_group_prefix}-%s","ManagedAD")}"
#     } 
# }

resource "aws_ec2_transit_gateway_route" "static_routes" {
  count                          = var.static_routes_only ? length(var.target_static_route_cidrs) : 0
  destination_cidr_block         = var.target_static_route_cidrs[count.index]
  transit_gateway_attachment_id  = aws_vpn_connection.transit_gateway.transit_gateway_attachment_id
  transit_gateway_route_table_id = var.transit_gateway_route_table_id
}
