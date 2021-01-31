
test

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
| enable\_s3\_endpoint | Enable the creation of the S3 Endpoint; default: false | `bool` | `false` | no |
| environment | Environment - eg. 'sbx', 'dev','qa','prod' | `string` | `""` | no |
| name | Name | `string` | n/a | yes |
| namespace | Namespace - 'clk' or 'clklab' | `string` | `""` | no |
| region | AWS region | `string` | `"us-east-1"` | no |
| route\_table\_ids | List of route table IDs for the VPC | `list(any)` | `[]` | no |
| vpc\_id | VPC ID to attach the endpoint to. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| s3\_arn | The ID of the VPC |
| s3\_id | The ID of the VPC |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->