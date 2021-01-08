output "virtual_gateway_id" {
  description = "The ID of the virtual gateway."
  value       = aws_vpn_gateway.dx_vgw.id
}