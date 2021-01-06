
# output "route_table_public" {
#     value = aws_route_table.public
# }

# output "public_subnets" {
#     value = aws_subnet.public.*
# }

output "public_subnets_ids" {
  value       = [for k, v in aws_subnet.public : v.id]
  description = "Public Subet IDs"
}

output "public_route_table_id" {
  value       = join("", aws_route_table.public.*.id)
  description = "Public Subnet Route Table ID"
}

output "private_subnets_ids" {
  value       = [for k, v in aws_subnet.private : v.id]
  description = "Private Subnet IDs"
}

output "private_route_table_id" {
  value       = join("", aws_route_table.private.*.id)
  description = "Private Subnet Route Table ID"
}

output "subnet_ids" {
  value       = var.type == "public" ? [for k, v in aws_subnet.public : v.id] : [for k, v in aws_subnet.private : v.id]
  description = "List of subent id's"
}

output "route_table_id" {
  value       = var.type == "public" ? join("", aws_route_table.public.*.id) : join("", aws_route_table.private.*.id)
  description = "Subnet Route Table ID"
}

output "nat_gateway_id" {
  value       = join("", aws_nat_gateway.default.*.id)
  description = "NAT Gateway ID"
}

output "nat_gateway_private_ip" {
  value       = join("", aws_nat_gateway.default.*.private_ip)
  description = "NAT Gateway Private IP"
}

output "nat_gateway_public_ip" {
  value       = join("", aws_nat_gateway.default.*.public_ip)
  description = "NAT Gateway Public IP"
}