# SAP PO Appliation Load Balancer
Allows for the provsioing of an AWS ALB along with a listener, default rule, targets, target groups, association to an certificate, security group and forward rules to a backend. 

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_lb.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.http](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_listener.https](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_listener_rule.http](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule) | resource |
| [aws_lb_listener_rule.https](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule) | resource |
| [aws_lb_target_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_lb_target_group_attachment.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment) | resource |
| [aws_security_group.lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_logs_bucket"></a> [access\_logs\_bucket](#input\_access\_logs\_bucket) | The name of the S3 bucket to use for the access log. | `string` | `""` | no |
| <a name="input_access_logs_enabled"></a> [access\_logs\_enabled](#input\_access\_logs\_enabled) | A boolean flag to determine whether the ALB should use and S3 access log. | `bool` | `false` | no |
| <a name="input_access_logs_prefix"></a> [access\_logs\_prefix](#input\_access\_logs\_prefix) | The prefix to use in the of the S3 bucket to use for the access log. | `string` | `""` | no |
| <a name="input_customer"></a> [customer](#input\_customer) | Customer (internal/external) Name - billing tag | `string` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | A description of the resource - used in tagging. | `string` | n/a | yes |
| <a name="input_enable_http"></a> [enable\_http](#input\_enable\_http) | Enable a front end HTTP (Port 80) listener. | `bool` | `false` | no |
| <a name="input_enable_http2"></a> [enable\_http2](#input\_enable\_http2) | A boolean flag to determine whether the ALB should use http2. | `bool` | `true` | no |
| <a name="input_enable_https"></a> [enable\_https](#input\_enable\_https) | Enable a front end HTTPS (Port 443) listener. | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment - used in tagging and name generation. | `string` | `""` | no |
| <a name="input_forward_rules"></a> [forward\_rules](#input\_forward\_rules) | A list of listener forward rule paths. | `list(any)` | n/a | yes |
| <a name="input_healthcheck_path"></a> [healthcheck\_path](#input\_healthcheck\_path) | The path for the health check. if left blank it will default to the target protocol. | `string` | `null` | no |
| <a name="input_healthcheck_port"></a> [healthcheck\_port](#input\_healthcheck\_port) | The port for the health check. if left blank it will default to the target port. | `string` | `null` | no |
| <a name="input_healthcheck_protocol"></a> [healthcheck\_protocol](#input\_healthcheck\_protocol) | The protocol for the health check. if left blank it will default to the target protocol. | `string` | `null` | no |
| <a name="input_internal"></a> [internal](#input\_internal) | A boolean flag to determine whether the ALB should be internal | `bool` | `false` | no |
| <a name="input_ip_address_type"></a> [ip\_address\_type](#input\_ip\_address\_type) | Controls the use of ipv4 or a dualstack address type. | `string` | `"ipv4"` | no |
| <a name="input_lb_egress_map"></a> [lb\_egress\_map](#input\_lb\_egress\_map) | A map of egress security groups. | `map(any)` | `{}` | no |
| <a name="input_lb_ingress_map"></a> [lb\_ingress\_map](#input\_lb\_ingress\_map) | A map of ingress security groups. | `map(any)` | `{}` | no |
| <a name="input_lb_name"></a> [lb\_name](#input\_lb\_name) | Additional name for the ALB that will be used in the name creation. | `string` | n/a | yes |
| <a name="input_lb_security_groups_ids"></a> [lb\_security\_groups\_ids](#input\_lb\_security\_groups\_ids) | A list of additional security groups that will be assigned to the ALB. | `list(string)` | `[]` | no |
| <a name="input_listener_certificate_arn"></a> [listener\_certificate\_arn](#input\_listener\_certificate\_arn) | The ARN of the Certificate for the HTTPS listener. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Name or application - used in tagging and name generation | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace - used in tagging and name generation. | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | `"us-east-1"` | no |
| <a name="input_stickiness_duration"></a> [stickiness\_duration](#input\_stickiness\_duration) | The duration of the stickiness of the cookie. Default: 1D | `string` | `null` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | List of the subnets to deploy the ALB to. | `list(string)` | n/a | yes |
| <a name="input_target_instance"></a> [target\_instance](#input\_target\_instance) | The instance id of the target to assign to the target group. | `string` | n/a | yes |
| <a name="input_target_port"></a> [target\_port](#input\_target\_port) | The port of for the target group. | `string` | `"443"` | no |
| <a name="input_target_protocol"></a> [target\_protocol](#input\_target\_protocol) | The protocol for the target group (HTTP/HTTPS) | `string` | `"HTTPS"` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The VPC to create the security groups, IAM roles, and deploy the Stoage Gateway instance in. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alb_arn"></a> [alb\_arn](#output\_alb\_arn) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->