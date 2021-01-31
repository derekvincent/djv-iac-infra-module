
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
| block\_public\_acls | Block Public acls; default: true | `bool` | `true` | no |
| block\_public\_policy | Block Public policy; default: true | `bool` | `true` | no |
| bucket\_name | The bucket postfix name or full named based on the custom\_bucket\_name setting. | `string` | n/a | yes |
| custom\_bucket\_name | If set to false then the bucket\_name will have the standard determined prefix applied. If it is set to true then the only provided bucket name will be used. default: false | `bool` | `false` | no |
| customer | Customer Name - billing tag | `string` | n/a | yes |
| enable\_versioning | Enable bucket versioning; default: false | `bool` | `false` | no |
| environment | Environment - eg. 'sbx', 'dev','qa','prod' | `string` | `""` | no |
| ignore\_public\_acls | Ignore Public acls; default: true | `bool` | `true` | no |
| name | Name | `string` | n/a | yes |
| namespace | Namespace - 'clk' or 'clklab' | `string` | `""` | no |
| region | AWS region | `string` | `"us-east-1"` | no |
| restrict\_public\_buckets | Restrict Public buckets; default: true | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| bucket\_arn | S3 state arn |
| bucket\_id | S3 state bucket id |
| bucket\_name | S3 state bucket domain name |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->