output "customer_gateway_id" {
  description = "Customer Gateway ID."
  value       = aws_customer_gateway.default.id
}

output "vpn_attachment_id" {
  description = "Customer Gateway VPN attachment id to the customer gateway."
  value       = aws_vpn_connection.transit_gateway.transit_gateway_attachment_id
}