
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
| resolver\_rule\_ids | List of Route53 Resolver Rules ID's to associate to the VPC. | `list(string)` | n/a | yes |
| vpc\_id | VPC ID to assicate to the Route53 Resolver Rules. | `string` | n/a | yes |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->