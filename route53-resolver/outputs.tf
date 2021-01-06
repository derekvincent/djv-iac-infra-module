output "resolver_forward_rule_ids" {
  value = [for key, value in aws_route53_resolver_rule.forward :
    value["id"]
  ]
}

output "inbound_resolver_ips" {
  value = flatten([for key, value in aws_route53_resolver_endpoint.inbound.*.ip_address :
    value.*.ip
  ])
}

output "outbound_resolver_ips" {
  value = flatten([for key, value in aws_route53_resolver_endpoint.outbound.*.ip_address :
    value.*.ip
  ])
}