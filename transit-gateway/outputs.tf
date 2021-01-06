output "id" {
  description = "Transit Gateway ID"
  value       = join("", aws_ec2_transit_gateway.default.*.id)
}

output "route_table_id" {
  value = join("", aws_ec2_transit_gateway.default.*.association_default_route_table_id)
}