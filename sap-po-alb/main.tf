locals {

  health_check_protocol = var.healthcheck_protocol == null ? var.target_protocol : var.healthcheck_protocol
  health_check_port     = var.healthcheck_port == null ? var.target_port : var.healthcheck_port

  alb_name = lower(join("-", [var.namespace, var.name, var.environment, var.lb_name, "alb"]))
  sg_name  = lower(join("-", [var.namespace, var.name, var.environment, var.lb_name, "sg"]))
  tg_name  = lower(join("-", [var.lb_name, var.target_protocol, var.target_port]))
  ## TAGS
  tag_name_env         = join(":", [var.namespace, "environment"])
  tag_name_customer    = join(":", [var.namespace, "customer"])
  tag_name_application = join(":", [var.namespace, "application"])
  tag_name_description = join(":", [var.namespace, "description"])

  common_tags = map(
    local.tag_name_env, var.environment,
    local.tag_name_customer, var.customer,
    local.tag_name_application, var.name,
    local.tag_name_description, var.description,
  )

  #alb_security_groups = compact([aws_security_group.lb.id, var.lb_security_groups_ids])    
  alb_security_groups = compact(concat([aws_security_group.lb.id], var.lb_security_groups_ids))

}

#tfsec:ignore:AWS005 tfsec:ignore:AWS083
resource "aws_lb" "default" {
  name               = var.lb_name
  subnets            = var.subnet_ids
  internal           = var.internal #tfsec:ignore:AWS005
  security_groups    = local.alb_security_groups
  load_balancer_type = "application"
  enable_http2       = var.enable_http2
  ip_address_type    = var.ip_address_type

  access_logs {
    bucket  = var.access_logs_bucket
    prefix  = var.access_logs_prefix
    enabled = var.access_logs_enabled
  }

  tags = merge(
    local.common_tags,
    map(
      "Name", local.alb_name
    )
  )
}

## Create the Target Group 
resource "aws_lb_target_group" "default" {
  name        = local.tg_name
  port        = var.target_port
  protocol    = var.target_protocol
  target_type = "instance"
  vpc_id      = var.vpc_id

  health_check {
    protocol = local.health_check_protocol
    path     = var.healthcheck_path
    port     = local.health_check_port
    #timeout             = var.health_check_timeout
    #healthy_threshold   = var.health_check_healthy_threshold
    #unhealthy_threshold = var.health_check_unhealthy_threshold
    #interval            = var.health_check_interval
    #matcher             = var.health_check_matcher
  }

  stickiness {
    type            = "lb_cookie"
    enabled         = true
    cookie_duration = var.stickiness_duration
  }

  tags = merge(
    local.common_tags,
    map(
      "Name", local.tg_name
    )
  )
}

## Attach it it a resource
resource "aws_lb_target_group_attachment" "default" {
  target_group_arn = aws_lb_target_group.default.arn
  target_id        = var.target_instance
  port             = var.target_port
}

## Default Action 
resource "aws_lb_listener" "http" {
  for_each          = var.enable_http ? { "HTTP" : "" } : {}
  load_balancer_arn = aws_lb.default.arn
  port              = "80"
  #tfsec:ignore:AWS004
  protocol = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "These are not the reources your looking for."
      status_code  = "404"
    }
  }
}

resource "aws_lb_listener_rule" "http" {
  for_each     = var.enable_http ? { "HTTP" : "" } : {}
  listener_arn = aws_lb_listener.http[each.key].arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.default.arn
  }

  condition {
    path_pattern {
      values = var.forward_rules
    }
  }

}

resource "aws_lb_listener" "https" {
  for_each          = var.enable_https ? { "HTTPS" : "" } : null
  load_balancer_arn = aws_lb.default.arn
  port              = "443"
  protocol          = "HTTPS"
  #tfsec:ignore:AWS010
  ssl_policy      = "ELBSecurityPolicy-2016-08"
  certificate_arn = var.listener_certificate_arn

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "These are not the reources your looking for."
      status_code  = "404"
    }
  }
}

resource "aws_lb_listener_rule" "https" {
  for_each     = var.enable_https ? { "HTTPS" : "" } : null
  listener_arn = aws_lb_listener.https[each.key].arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.default.arn
  }

  condition {
    path_pattern {
      values = var.forward_rules
    }
  }

}