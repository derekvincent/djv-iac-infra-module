
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
| assumed\_shared\_roles | List of possible roles that the instance can assume. | `list(string)` | `[]` | no |
| customer | Customer Name - billing tag | `string` | n/a | yes |
| ebs\_disk\_layouts | Map of the additional ebs values to be added. | `map(any)` | n/a | yes |
| ebs\_optimized | Enable the EBS optimization on the instance if support; default: false | `bool` | `false` | no |
| ec2\_ami | AMI for the Instance being created. | `string` | n/a | yes |
| ec2\_instance\_type | EC2 Instance Type. | `string` | n/a | yes |
| ec2\_private\_ip | Sets the instances IP address. If not set then a random subnet IP address will be used. | `string` | `null` | no |
| enable\_enhanced\_monitoring | Enable Enhanced Cloudwatch Monitoring; default: true. | `bool` | `true` | no |
| enable\_public\_address | Enable assignment of a public address when in a public subnet; default: false. | `bool` | `false` | no |
| environment | Environment - eg. 'sbx', 'dev','qa','prod' | `string` | `""` | no |
| hostname | Hostname of the instance used for tagging. | `string` | `""` | no |
| iam\_instance\_profile | The name of the IAM instance profile to assign to the instance. | `string` | `""` | no |
| instance\_name | Name for the Instance. | `string` | n/a | yes |
| key\_name | EC2 instance keypair to use. | `string` | n/a | yes |
| name | Name | `string` | n/a | yes |
| namespace | Namespace - 'clk' or 'clklab' | `string` | `""` | no |
| region | AWS region | `string` | `"us-east-1"` | no |
| root\_volume\_encrypted | Enable Root Volume Encryption; default: true. | `bool` | `true` | no |
| root\_volume\_size | Root Volume size; default: 20. | `string` | `"20"` | no |
| root\_volume\_type | Root Volume type - standard, gp2, io1 or io2; default: gp2). | `string` | `"gp2"` | no |
| security\_groups | List of Security groups to add to the instance. | `list(any)` | `[]` | no |
| subnet\_id | VPC Subnet ID to deploy the instnace in. | `string` | n/a | yes |
| swap\_volume\_encrypted | Enable Swap Volume Encryption; default: true. | `bool` | `true` | no |
| swap\_volume\_size | Swap Volume size. | `string` | n/a | yes |
| swap\_volume\_type | Swap Volume type - standard, gp2, io1 or io2; default: standard). | `string` | `"standard"` | no |
| termination\_protection | Instance termination protection default:true. | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| ebs\_volume\_attachments | n/a |
| ebs\_volumes | n/a |
| instance | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->