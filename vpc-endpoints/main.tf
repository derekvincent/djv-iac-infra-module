locals {
  s3_service_name = join(".", ["com.amazonaws", var.region, "s3"])
  s3_tag_name     = join("-", [var.namespace, var.name, var.environment, "s3", "vpce"])
  #e2_service_name = join(".", ["com.amazonaws", var.region, "ec2"])
  #s3_tag_name = join("-", [var.namespace, var.name, var.environment, "ec2", "vpce"])
  tag_name_env      = join(":", [var.namespace, "environment"])
  tag_name_customer = join(":", [var.namespace, "customer"])
  common_tags = map(
    local.tag_name_env, var.environment,
    local.tag_name_customer, var.customer
  )
}

resource "aws_vpc_endpoint" "s3" {
  count           = var.enable_s3_endpoint ? 1 : 0
  vpc_id          = var.vpc_id
  service_name    = local.s3_service_name
  route_table_ids = var.route_table_ids
  #    policy         = TO BE SUPPORTED LATER!
  tags = merge(
    local.common_tags,
    map(
      "Name", local.s3_tag_name
    )
  )
}

# resource "aws_vpc_endpoint_route_table_association" "s3" {
#     count           = var.enable_s3_endpoint ? length(var.route_table_ids) : 0
#     route_table_id  = var.route_table_ids[count.index]
#     vpc_endpoint_id = aws_vpc_endpoint.s3.id
# }