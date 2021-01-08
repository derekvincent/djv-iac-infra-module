# Virtual Private Gateway and Direct Connect Gateway Proposal

This module will create a `Virtual Gateway` assosicate it with the VPC referenced, enables route propogation with referenced route tables and creates a association propsal to the referenced `Direct Connect Gateway`. 

## Module Assumption 
- The approval of the propsal is not handled in this module.
- The VPC assigned CIDR block is used as the Direct Connect Gateways `allowed_prefixes`.
- The Direct Connect Gateway is **always** in another account.  


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
| amazon\_side\_asn | The BGP ASN to assign to the Virtual Private Gateway. | `string` | `"64512"` | no |
| customer | Customer (internal/external) Name - billing tag | `string` | n/a | yes |
| dx\_gateway\_account\_id | The Account ID of the Direct Connect Gateway to attach to. | `string` | n/a | yes |
| dx\_gateway\_id | The Direct Connect Gateway ID to attach to. | `string` | n/a | yes |
| environment | Environment - used in tagging and name generation. | `string` | `""` | no |
| name | Name or application - used in tagging and name generation | `string` | n/a | yes |
| namespace | Namespace - used in tagging and name generation. | `string` | `""` | no |
| region | AWS region | `string` | `"us-east-1"` | no |
| route\_table\_ids | A list of route table IDs to assign Virtual Private Gateway with propogation. | `list(string)` | n/a | yes |
| vpc\_id | VPC the Virtual Private Gateway will be associated with. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| virtual\_gateway\_id | The ID of the virtual gateway. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->