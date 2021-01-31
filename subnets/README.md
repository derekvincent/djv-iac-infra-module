
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
| enable\_nat\_gateway | Enable Nat Gateway | `bool` | `false` | no |
| environment | Environment - eg. 'sbx', 'dev','qa','prod' | `string` | `""` | no |
| igw\_id | VPC Internet Gateway ID | `string` | `""` | no |
| name | Name | `string` | n/a | yes |
| namespace | Namespace - 'clk' or 'clklab' | `string` | `""` | no |
| ngw\_id | NAT Gateway ID | `string` | `""` | no |
| private\_subnets | A list of subnet CIDRs | `map(any)` | `{}` | no |
| public\_subnets | A list of subnet CIDRs | `map(any)` | `{}` | no |
| region | AWS region | `string` | `"us-east-1"` | no |
| type | Type of subnets (`private` or `public`) | `string` | `"private"` | no |
| vpc\_id | VPC ID the subnet will be created in. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| nat\_gateway\_id | NAT Gateway ID |
| nat\_gateway\_private\_ip | NAT Gateway Private IP |
| nat\_gateway\_public\_ip | NAT Gateway Public IP |
| private\_route\_table\_id | Private Subnet Route Table ID |
| private\_subnets\_ids | Private Subnet IDs |
| public\_route\_table\_id | Public Subnet Route Table ID |
| public\_subnets\_ids | Public Subet IDs |
| route\_table\_id | Subnet Route Table ID |
| subnet\_ids | List of subent id's |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->