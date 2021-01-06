
output "zone_id" {
  value = aws_route53_zone.private.zone_id
}

output "zone_name" {
  value = aws_route53_zone.private.name
}

output "private_zone_policy_name" {
  value = aws_iam_policy.private_zone.name
}

output "private_zone_policy_id" {
  value = aws_iam_policy.private_zone.id
}

output "private_zone_policy_arn" {
  value = aws_iam_policy.private_zone.arn
}