## Create a Route53 VPC zone association 

resource "aws_route53_zone_association" "default" {
  zone_id = var.zone_id
  vpc_id  = var.vpc_id
}