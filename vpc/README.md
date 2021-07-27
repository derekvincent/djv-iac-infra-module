# Base VPC 

Creates a new VPC along with the default security group, route table, ACL, Internet Gateway, DHCP options. 

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
| dns\_domain\_name | Default DNS Domain Name for the VPC - Sets in the DHCP OPtion Set | `string` | n/a | yes |
| dns\_server\_list | List of DNS Servers | `list(any)` | <pre>[<br>  "AmazonProvidedDNS"<br>]</pre> | no |
| enable\_dns\_hostname | A boolean flag to enable/disable DNS hostnames in the VPC. | `bool` | `true` | no |
| enable\_dns\_support | A boolean flag to enable/disable DNS support in the VPC. | `bool` | `true` | no |
| enable\_internet\_gateway | Enable th creation of an internet gateway for the VPC | `bool` | `true` | no |
| environment | Environment - eg. 'sbx', 'dev','qa','prod' | `string` | `""` | no |
| name | Name | `string` | n/a | yes |
| namespace | Namespace - 'clk' or 'clklab' | `string` | `""` | no |
| region | AWS region | `string` | `"us-east-1"` | no |
| vpc\_cidr | CIRD for the VPC | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| dns\_domain\_name | The DNS domain name of the VPC |
| igw\_id | The ID of the VPC |
| vpc\_cidr\_block | The CIDR block of the VPC |
| vpc\_default\_network\_acl\_id | The ID of the network ACL created by default on VPC creation |
| vpc\_default\_security\_group\_id | The ID of the security group created by default on VPC creation |
| vpc\_id | The ID of the VPC |
| vpc\_main\_route\_table\_id | The ID of the main route table associated with this VPC |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->