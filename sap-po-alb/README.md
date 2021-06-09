
Will edit later.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Modules

No Modules.

## Resources

| Name |
|------|
| [aws_lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) |
| [aws_lb_listener](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) |
| [aws_lb_listener_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule) |
| [aws_lb_target_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) |
| [aws_lb_target_group_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment) |
| [aws_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) |
| [aws_security_group_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| access\_logs\_bucket | The name of the S3 bucket to use for the access log. | `string` | `""` | no |
| access\_logs\_enabled | A boolean flag to determine whether the ALB should use and S3 access log. | `bool` | `false` | no |
| access\_logs\_prefix | The prefix to use in the of the S3 bucket to use for the access log. | `string` | `""` | no |
| customer | Customer (internal/external) Name - billing tag | `string` | n/a | yes |
| description | A description of the resource - used in tagging. | `string` | n/a | yes |
| enable\_http | Enable a front end HTTP (Port 80) listener. | `bool` | `false` | no |
| enable\_http2 | A boolean flag to determine whether the ALB should use http2. | `bool` | `true` | no |
| enable\_https | Enable a front end HTTPS (Port 443) listener. | `bool` | `true` | no |
| environment | Environment - used in tagging and name generation. | `string` | `""` | no |
| forward\_rules | A list of listener forward rule paths. | `list(any)` | n/a | yes |
| healthcheck\_path | The path for the health check. if left blank it will default to the target protocol. | `string` | `null` | no |
| healthcheck\_port | The port for the health check. if left blank it will default to the target port. | `string` | `null` | no |
| healthcheck\_protocol | The protocol for the health check. if left blank it will default to the target protocol. | `string` | `null` | no |
| internal | A boolean flag to determine whether the ALB should be internal | `bool` | `false` | no |
| ip\_address\_type | Controls the use of ipv4 or a dualstack address type. | `string` | `"ipv4"` | no |
| lb\_egress\_map | A map of egress security groups. | `map(any)` | `{}` | no |
| lb\_ingress\_map | A map of ingress security groups. | `map(any)` | `{}` | no |
| lb\_name | Additional name for the ALB that will be used in the name creation. | `string` | n/a | yes |
| lb\_security\_groups\_ids | A list of additional security groups that will be assigned to the ALB. | `list(string)` | `[]` | no |
| listener\_certificate\_arn | The ARN of the Certificate for the HTTPS listener. | `string` | `null` | no |
| name | Name or application - used in tagging and name generation | `string` | n/a | yes |
| namespace | Namespace - used in tagging and name generation. | `string` | `""` | no |
| region | AWS region | `string` | `"us-east-1"` | no |
| stickiness\_duration | The duration of the stickiness of the cookie. Default: 1D | `string` | `null` | no |
| subnet\_ids | List of the subnets to deploy the ALB to. | `list(string)` | n/a | yes |
| target\_instance | The instance id of the target to assign to the target group. | `string` | n/a | yes |
| target\_port | The port of for the target group. | `string` | `"443"` | no |
| target\_protocol | The protocol for the target group (HTTP/HTTPS) | `string` | `"HTTPS"` | no |
| vpc\_id | The VPC to create the security groups, IAM roles, and deploy the Stoage Gateway instance in. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| alb\_arn | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->