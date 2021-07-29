# Transit Gateway/VPC routing rules
Allows for the setting defined routing rules against a specific table and against a Transit Gateway or VPC peering connection.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| customer | Customer Name - billing tag | `string` | n/a | yes |
| destination\_cidr\_blocks | List of CIDR targets blocks | `list(any)` | `[]` | no |
| environment | Environment - eg. 'sbx', 'dev','qa','prod' | `string` | `""` | no |
| name | Name | `string` | n/a | yes |
| namespace | Namespace - 'clk' or 'clklab' | `string` | `""` | no |
| region | AWS region | `string` | `"us-east-1"` | no |
| route\_table\_id | Route Table ID | `string` | n/a | yes |
| transit\_gateway\_id | Transit Gateway ID | `string` | `null` | no |
| vpc\_peering\_id | VPC Perring Connection ID | `string` | `null` | no |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->