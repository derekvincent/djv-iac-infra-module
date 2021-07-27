# Route53 Record

Manage Route53 DNS records in the created zones. Provides the ability to create an a, cname and reverse record in-addr.arpa. 


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
| name | The record name that is being added. | `string` | n/a | yes |
| records | A list of the records being added. ie: IP addresses or other alias. | `list(any)` | n/a | yes |
| ttl | The Time-To-Live of the records being added; default: 300 | `string` | `"300"` | no |
| type | The record type to create. Currrently only A and CNAME support. | `string` | n/a | yes |
| zone\_id | The Zone ID the record is being added to. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| fqdn | n/a |
| name | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->