
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
| acceptor\_allow\_remote\_vpc\_dns\_resolution | Allow acceptor VPC to resolve public DNS hostnames to private IP addresses when queried from instances in the requestor VPC | `bool` | `true` | no |
| acceptor\_vpc\_id | Acceptor VPC ID | `string` | `""` | no |
| acceptor\_vpc\_name\_tag | Acceptor VPC Name tag | `string` | `""` | no |
| auto\_accept | Automatically accept the peering (both VPCs need to be in the same AWS account) | `bool` | `true` | no |
| create\_timeout | VPC peering connection create timeout. For more details, see https://www.terraform.io/docs/configuration/resources.html#operation-timeouts | `string` | `"3m"` | no |
| customer | Customer Name - billing tag | `string` | n/a | yes |
| delete\_timeout | VPC peering connection delete timeout. For more details, see https://www.terraform.io/docs/configuration/resources.html#operation-timeouts | `string` | `"5m"` | no |
| enabled | Set to false to prevent the module from creating or accessing any resources | `bool` | `true` | no |
| environment | Environment - eg. 'sbx', 'dev','qa','prod' | `string` | `""` | no |
| name | Name | `string` | n/a | yes |
| namespace | Namespace - 'clk' or 'clklab' | `string` | `""` | no |
| region | AWS region | `string` | `"us-east-1"` | no |
| requestor\_allow\_remote\_vpc\_dns\_resolution | Allow requestor VPC to resolve public DNS hostnames to private IP addresses when queried from instances in the acceptor VPC | `bool` | `true` | no |
| requestor\_private\_route\_table\_id | Requestor Private Route Table ID | `string` | `""` | no |
| requestor\_public\_route\_table\_id | Requestor Public Route Table ID | `string` | `""` | no |
| requestor\_vpc\_id | Requestor VPC ID | `string` | `""` | no |
| requestor\_vpc\_tags | Requestor VPC tags | `map(string)` | `{}` | no |
| update\_timeout | VPC peering connection update timeout. For more details, see https://www.terraform.io/docs/configuration/resources.html#operation-timeouts | `string` | `"3m"` | no |

## Outputs

| Name | Description |
|------|-------------|
| vpc\_acceptor | n/a |
| vpc\_requestor | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->