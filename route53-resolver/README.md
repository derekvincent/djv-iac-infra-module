
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
| create\_security\_group | Creates a security group to be used with the In/Out resolvers and use the forward\_rules\_map dns servers; default: true | `bool` | `true` | no |
| customer | Customer Name - billing tag | `string` | n/a | yes |
| enable\_inbound\_resolver | Enable the creation of an inbound resolver; default: true | `bool` | `true` | no |
| enable\_outbound\_resolver | Enable the creation of an outbound resolver; default: true | `bool` | `true` | no |
| environment | Environment - eg. 'sbx', 'dev','qa','prod' | `string` | `""` | no |
| forward\_rules\_map | A Map of the forward rules { "domain" : ["dns server 1", "dns server 2", "dns server X"] } | `map(any)` | n/a | yes |
| in\_ip1\_address | Specify an IP to use in your VPC/Subnet to set the as the resolver endpoint. If left blank one will be auto assigned. | `string` | `null` | no |
| in\_ip2\_address | Specify an IP to use in your VPC/Subnet to set the as the resolver endpoint. If left blank one will be auto assigned. | `string` | `null` | no |
| in\_subnet\_1\_id | Subnet ID to put the first Resolver endpoint in | `string` | n/a | yes |
| in\_subnet\_2\_id | Subnet ID to put the second Resolver endpoint in | `string` | n/a | yes |
| name | Name | `string` | n/a | yes |
| namespace | Namespace - 'clk' or 'clklab' | `string` | `""` | no |
| out\_ip1\_address | Specify an IP to use in your VPC/Subnet to set the as the resolver endpoint. If left blank one will be auto assigned. | `string` | `null` | no |
| out\_ip2\_address | Specify an IP to use in your VPC/Subnet to set the as the resolver endpoint. If left blank one will be auto assigned. | `string` | `null` | no |
| out\_subnet\_1\_id | Subnet ID to put the first Resolver endpoint in | `string` | n/a | yes |
| out\_subnet\_2\_id | Subnet ID to put the second Resolver endpoint in | `string` | n/a | yes |
| region | AWS region | `string` | `"us-east-1"` | no |
| security\_group\_ids | A list of security groups to be used if not letting the module create one. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| vpc\_id | The ID of the VPC to assign the created security group to. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| inbound\_resolver\_ips | n/a |
| outbound\_resolver\_ips | n/a |
| resolver\_forward\_rule\_ids | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->