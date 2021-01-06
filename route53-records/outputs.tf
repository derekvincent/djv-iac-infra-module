output "name" {
  value = join("", coalesce(aws_route53_record.a.*.name, aws_route53_record.cname.*.name))
}

output "fqdn" {
  value = join("", coalesce(aws_route53_record.a.*.fqdn, aws_route53_record.cname.*.fqdn))
}