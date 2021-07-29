# Route53 Zone Association
Manage the association between additional VPC's and the Route53 domain. Allows for VPC's in other account to be part of a single Route53 private domain. 

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
| vpc\_id | VPC ID to associate to the Route53 domain | `string` | n/a | yes |
| zone\_id | Zone ID of the Route53 domain | `string` | n/a | yes |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->