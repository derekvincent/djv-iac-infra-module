
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
| vpc\_id | VPC ID of the association in the non-hosting zone. | `string` | n/a | yes |
| zone\_id | The Route53 zone ID to authorize the association | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| authorization\_id | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->