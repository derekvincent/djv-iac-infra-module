# Route53 Zone

Creates a Private Route53 zone and attaches the default VPC to it. 

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
| dns\_domain\_name | DNS Domain Name | `string` | n/a | yes |
| environment | Environment - eg. 'sbx', 'dev','qa','prod' | `string` | `""` | no |
| name | Name | `string` | n/a | yes |
| namespace | Namespace - 'clk' or 'clklab' | `string` | `""` | no |
| region | AWS region | `string` | `"us-east-1"` | no |
| vpc\_id | VPC ID the subnet will be created in. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| private\_zone\_policy\_arn | n/a |
| private\_zone\_policy\_id | n/a |
| private\_zone\_policy\_name | n/a |
| zone\_id | n/a |
| zone\_name | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->