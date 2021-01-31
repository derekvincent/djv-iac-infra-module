
test

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| random | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| access\_points | A list of access points to be created | `map(any)` | `{}` | no |
| customer | Customer Name - billing tag | `string` | n/a | yes |
| description | EFS Usage Description | `string` | n/a | yes |
| detail\_name | Additional Detailed name - <namespace>-<name>-<environment>-<detail\_name>-efs: clkwrk-sap-shared-trans-efs. | `string` | n/a | yes |
| environment | Environment - eg. 'sbx', 'dev','qa','prod' | `string` | `""` | no |
| mount\_subnets | List of subnet IDs to create mount targets in. | `list(any)` | n/a | yes |
| name | Name | `string` | n/a | yes |
| namespace | Namespace - 'clk' or 'clklab' | `string` | `""` | no |
| region | AWS region | `string` | `"us-east-1"` | no |
| security\_group\_cidrs | A list of CIDRS that are allowed access to the EFS file system. | `list(string)` | `[]` | no |
| security\_group\_prefix\_list\_ids | A list of Prefix Lists that are allowed access to the EFS file system. | `list(string)` | `[]` | no |
| transition\_to\_ia | Indicates how long it takes to transition files to the IA storage class. Valid values: AFTER\_7\_DAYS, AFTER\_14\_DAYS, AFTER\_30\_DAYS, AFTER\_60\_DAYS and AFTER\_90\_DAYS | `string` | `""` | no |
| vpc\_id | VPC ID the subnet will be created in. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| access\_points | n/a |
| efs\_arn | n/a |
| efs\_domain\_name | n/a |
| efs\_id | n/a |
| mount\_targets | n/a |
| mount\_targets\_ips\_as\_cidr | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->