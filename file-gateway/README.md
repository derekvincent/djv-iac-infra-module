
Will edit later.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Modules

No Modules.

## Resources

| Name |
|------|
| [aws_ebs_volume](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ebs_volume) |
| [aws_iam_instance_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) |
| [aws_iam_policy_document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) |
| [aws_iam_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) |
| [aws_iam_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) |
| [aws_iam_role_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) |
| [aws_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) |
| [aws_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) |
| [aws_security_group_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) |
| [aws_ssm_parameter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) |
| [aws_storagegateway_cache](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/storagegateway_cache) |
| [aws_storagegateway_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/storagegateway_gateway) |
| [aws_storagegateway_local_disk](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/storagegateway_local_disk) |
| [aws_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) |
| [aws_volume_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/volume_attachment) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| admin\_cidrs | A list of CIDRs for Admin access over 80/443. | `list(any)` | n/a | yes |
| ads\_cidrs | A CIDR lisr of Active Directory when including the Storage Gateway in AD. | `list(any)` | `[]` | no |
| bucket\_arns | A list of Bucket ARNs that the Storage Gateway has access to. | `list(any)` | `[]` | no |
| cache\_volume\_encrypted | The cache volume encryption. | `bool` | `true` | no |
| cache\_volume\_size | The cache volume size. | `string` | `"150"` | no |
| cache\_volume\_type | The cache volume type. | `string` | `"gp2"` | no |
| customer | Customer (internal/external) Name - billing tag | `string` | n/a | yes |
| dns\_cidrs | A list of CIDRs to allow DNS access for the storage Gateway. If using local AWS Route53 allow access to the local subnet. | `list(any)` | n/a | yes |
| ec2\_instance\_type | The Instance type to deploy the File Gateway on. | `string` | `"m5.xlarge"` | no |
| enable\_enhanced\_monitoring | Enable enhanced cloudwatch monitoring. | `bool` | `true` | no |
| enable\_nfs\_v3 | Enable if NFS V3 clients (Windows) need access. | `bool` | `false` | no |
| environment | Environment - used in tagging and name generation. | `string` | `""` | no |
| gateway\_domain | The dns domain the gateway is deployed in. | `string` | n/a | yes |
| gateway\_name | The gateway hostname. | `string` | n/a | yes |
| gateway\_time\_zone | The time zone the gateway should use.  Entered in the format GMT-5:00 | `string` | `"GMT-5:00"` | no |
| key\_name | The name of the SSH key to be used to access the system. | `string` | n/a | yes |
| name | Name or application - used in tagging and name generation | `string` | n/a | yes |
| namespace | Namespace - used in tagging and name generation. | `string` | `""` | no |
| nfs\_cidrs | A NFS client access list of the CIDRs. | `list(any)` | `[]` | no |
| region | AWS region | `string` | `"us-east-1"` | no |
| root\_volume\_encrypted | The root volume encryption. | `bool` | `true` | no |
| root\_volume\_size | The root volume size. | `string` | `"80"` | no |
| root\_volume\_type | The root volume type. | `string` | `"gp2"` | no |
| smb\_cidrs | A Samba client acces lost of CIDRs. | `list(any)` | `[]` | no |
| sname | Specific name used in the nameing/tagging to distiguish multiple object of the same type. | `string` | `""` | no |
| subnet\_id | The Subnet in the VPC to deployt the File Gateway instance in. | `string` | n/a | yes |
| vpc\_id | The VPC to create the security groups, IAM roles, and deploy the Stoage Gateway instance in. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| ami\_id | n/a |
| file\_gateway\_arn | The arn of the file gateway. |
| file\_gateway\_role\_arn | n/a |
| fqdn | The fully qualified domain name. |
| instance | n/a |
| sg\_name | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->