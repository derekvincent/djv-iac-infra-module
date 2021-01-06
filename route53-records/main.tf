resource "aws_route53_record" "a" {
  count   = upper(var.type) == "A" ? 1 : 0
  zone_id = var.zone_id
  name    = var.name
  type    = "A"
  ttl     = var.ttl
  records = var.records
}

resource "aws_route53_record" "cname" {
  count   = upper(var.type) == "CNAME" ? 1 : 0
  zone_id = var.zone_id
  name    = var.name
  type    = "CNAME"
  ttl     = var.ttl
  records = var.records
}

resource "aws_route53_record" "reverse" {
  count   = upper(var.type) == "REVERSE" ? 1 : 0
  zone_id = var.zone_id
  #name    = var.name
  #name    = join(".",setsubtract(reverse(split(".", var.name)), split(".",trimsuffix(data.aws_route53_zone.default.name, ".in-addr.arpa"))))
  name = trimsuffix(
    trimsuffix(
      join(".", reverse(split(".", var.name))),
      join(".", split(".", trimsuffix(data.aws_route53_zone.default.name, ".in-addr.arpa")))
    ), "."
  )
  type    = "PTR"
  ttl     = var.ttl
  records = var.records
}

data "aws_route53_zone" "default" {
  zone_id = var.zone_id
}