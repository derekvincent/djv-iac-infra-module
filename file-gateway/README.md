# File Gateway
Provisions a Storage Gateway as a File Gateway along with an file gateway instance, a IAM roles and a security group. 

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ebs_volume.cache](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ebs_volume) | resource |
| [aws_iam_instance_profile.file_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.file_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.s3-bucket-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.cloudwatch](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.systems_manager](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_instance.file_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_security_group.file_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_storagegateway_cache.cache_volume](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/storagegateway_cache) | resource |
| [aws_storagegateway_gateway.file_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/storagegateway_gateway) | resource |
| [aws_volume_attachment.cache](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/volume_attachment) | resource |
| [aws_iam_policy_document.s3_bucket_policy_document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_ssm_parameter.latest_ec2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |
| [aws_storagegateway_local_disk.cache](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/storagegateway_local_disk) | data source |
| [aws_subnet.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_cidrs"></a> [admin\_cidrs](#input\_admin\_cidrs) | A list of CIDRs for Admin access over 80/443. | `list(any)` | n/a | yes |
| <a name="input_ads_cidrs"></a> [ads\_cidrs](#input\_ads\_cidrs) | A CIDR lisr of Active Directory when including the Storage Gateway in AD. | `list(any)` | `[]` | no |
| <a name="input_bucket_arns"></a> [bucket\_arns](#input\_bucket\_arns) | A list of Bucket ARNs that the Storage Gateway has access to. | `list(any)` | `[]` | no |
| <a name="input_cache_volume_encrypted"></a> [cache\_volume\_encrypted](#input\_cache\_volume\_encrypted) | The cache volume encryption. | `bool` | `true` | no |
| <a name="input_cache_volume_size"></a> [cache\_volume\_size](#input\_cache\_volume\_size) | The cache volume size. | `string` | `"150"` | no |
| <a name="input_cache_volume_type"></a> [cache\_volume\_type](#input\_cache\_volume\_type) | The cache volume type. | `string` | `"gp2"` | no |
| <a name="input_customer"></a> [customer](#input\_customer) | Customer (internal/external) Name - billing tag | `string` | n/a | yes |
| <a name="input_dns_cidrs"></a> [dns\_cidrs](#input\_dns\_cidrs) | A list of CIDRs to allow DNS access for the storage Gateway. If using local AWS Route53 allow access to the local subnet. | `list(any)` | n/a | yes |
| <a name="input_ec2_instance_type"></a> [ec2\_instance\_type](#input\_ec2\_instance\_type) | The Instance type to deploy the File Gateway on. | `string` | `"m5.xlarge"` | no |
| <a name="input_enable_enhanced_monitoring"></a> [enable\_enhanced\_monitoring](#input\_enable\_enhanced\_monitoring) | Enable enhanced cloudwatch monitoring. | `bool` | `true` | no |
| <a name="input_enable_nfs_v3"></a> [enable\_nfs\_v3](#input\_enable\_nfs\_v3) | Enable if NFS V3 clients (Windows) need access. | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment - used in tagging and name generation. | `string` | `""` | no |
| <a name="input_gateway_domain"></a> [gateway\_domain](#input\_gateway\_domain) | The dns domain the gateway is deployed in. | `string` | n/a | yes |
| <a name="input_gateway_name"></a> [gateway\_name](#input\_gateway\_name) | The gateway hostname. | `string` | n/a | yes |
| <a name="input_gateway_time_zone"></a> [gateway\_time\_zone](#input\_gateway\_time\_zone) | The time zone the gateway should use.  Entered in the format GMT-5:00 | `string` | `"GMT-5:00"` | no |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | The name of the SSH key to be used to access the system. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name or application - used in tagging and name generation | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace - used in tagging and name generation. | `string` | `""` | no |
| <a name="input_nfs_cidrs"></a> [nfs\_cidrs](#input\_nfs\_cidrs) | A NFS client access list of the CIDRs. | `list(any)` | `[]` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | `"us-east-1"` | no |
| <a name="input_root_volume_encrypted"></a> [root\_volume\_encrypted](#input\_root\_volume\_encrypted) | The root volume encryption. | `bool` | `true` | no |
| <a name="input_root_volume_size"></a> [root\_volume\_size](#input\_root\_volume\_size) | The root volume size. | `string` | `"80"` | no |
| <a name="input_root_volume_type"></a> [root\_volume\_type](#input\_root\_volume\_type) | The root volume type. | `string` | `"gp2"` | no |
| <a name="input_smb_cidrs"></a> [smb\_cidrs](#input\_smb\_cidrs) | A Samba client acces lost of CIDRs. | `list(any)` | `[]` | no |
| <a name="input_sname"></a> [sname](#input\_sname) | Specific name used in the nameing/tagging to distiguish multiple object of the same type. | `string` | `""` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The Subnet in the VPC to deployt the File Gateway instance in. | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The VPC to create the security groups, IAM roles, and deploy the Stoage Gateway instance in. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ami_id"></a> [ami\_id](#output\_ami\_id) | n/a |
| <a name="output_file_gateway_arn"></a> [file\_gateway\_arn](#output\_file\_gateway\_arn) | The arn of the file gateway. |
| <a name="output_file_gateway_role_arn"></a> [file\_gateway\_role\_arn](#output\_file\_gateway\_role\_arn) | n/a |
| <a name="output_fqdn"></a> [fqdn](#output\_fqdn) | The fully qualified domain name. |
| <a name="output_instance"></a> [instance](#output\_instance) | n/a |
| <a name="output_sg_name"></a> [sg\_name](#output\_sg\_name) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->