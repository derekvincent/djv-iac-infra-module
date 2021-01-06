
resource "aws_route53_resolver_rule_association" "default" {
  count            = length(var.resolver_rule_ids)
  resolver_rule_id = var.resolver_rule_ids[count.index]
  vpc_id           = var.vpc_id
}