# CommVault Media Agent 
Provisions an instance of a CommVault AMI for a media agent. 

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
| [aws_ebs_volume.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ebs_volume) | resource |
| [aws_instance.commvault_media_agent](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_volume_attachment.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/volume_attachment) | resource |
| [aws_subnet.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_assumed_shared_roles"></a> [assumed\_shared\_roles](#input\_assumed\_shared\_roles) | List of possible roles that the instance can assume. | `list(string)` | `[]` | no |
| <a name="input_customer"></a> [customer](#input\_customer) | Customer Name - billing tag | `string` | n/a | yes |
| <a name="input_ebs_disk_layouts"></a> [ebs\_disk\_layouts](#input\_ebs\_disk\_layouts) | Map of the additional ebs values to be added. | `map(any)` | n/a | yes |
| <a name="input_ebs_optimized"></a> [ebs\_optimized](#input\_ebs\_optimized) | Enable the EBS optimization on the instance if support; default: false | `bool` | `false` | no |
| <a name="input_ec2_ami"></a> [ec2\_ami](#input\_ec2\_ami) | AMI for the Instance being created. | `string` | n/a | yes |
| <a name="input_ec2_instance_type"></a> [ec2\_instance\_type](#input\_ec2\_instance\_type) | EC2 Instance Type. | `string` | n/a | yes |
| <a name="input_ec2_private_ip"></a> [ec2\_private\_ip](#input\_ec2\_private\_ip) | Sets the instances IP address. If not set then a random subnet IP address will be used. | `string` | `null` | no |
| <a name="input_enable_enhanced_monitoring"></a> [enable\_enhanced\_monitoring](#input\_enable\_enhanced\_monitoring) | Enable Enhanced Cloudwatch Monitoring; default: true. | `bool` | `true` | no |
| <a name="input_enable_public_address"></a> [enable\_public\_address](#input\_enable\_public\_address) | Enable assignment of a public address when in a public subnet; default: false. | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment - eg. 'sbx', 'dev','qa','prod' | `string` | `""` | no |
| <a name="input_hostname"></a> [hostname](#input\_hostname) | Hostname of the instance used for tagging. | `string` | `""` | no |
| <a name="input_iam_instance_profile"></a> [iam\_instance\_profile](#input\_iam\_instance\_profile) | The name of the IAM instance profile to assign to the instance. | `string` | `""` | no |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | Name for the Instance. | `string` | n/a | yes |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | EC2 instance keypair to use. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace - 'clk' or 'clklab' | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | `"us-east-1"` | no |
| <a name="input_root_volume_encrypted"></a> [root\_volume\_encrypted](#input\_root\_volume\_encrypted) | Enable Root Volume Encryption; default: true. | `bool` | `true` | no |
| <a name="input_root_volume_size"></a> [root\_volume\_size](#input\_root\_volume\_size) | Root Volume size; default: 20. | `string` | `"20"` | no |
| <a name="input_root_volume_type"></a> [root\_volume\_type](#input\_root\_volume\_type) | Root Volume type - standard, gp2, io1 or io2; default: gp2). | `string` | `"gp2"` | no |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | List of Security groups to add to the instance. | `list(any)` | `[]` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | VPC Subnet ID to deploy the instnace in. | `string` | n/a | yes |
| <a name="input_swap_volume_encrypted"></a> [swap\_volume\_encrypted](#input\_swap\_volume\_encrypted) | Enable Swap Volume Encryption; default: true. | `bool` | `true` | no |
| <a name="input_swap_volume_size"></a> [swap\_volume\_size](#input\_swap\_volume\_size) | Swap Volume size. | `string` | n/a | yes |
| <a name="input_swap_volume_type"></a> [swap\_volume\_type](#input\_swap\_volume\_type) | Swap Volume type - standard, gp2, io1 or io2; default: standard). | `string` | `"standard"` | no |
| <a name="input_termination_protection"></a> [termination\_protection](#input\_termination\_protection) | Instance termination protection default:true. | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ebs_volume_attachments"></a> [ebs\_volume\_attachments](#output\_ebs\_volume\_attachments) | n/a |
| <a name="output_ebs_volumes"></a> [ebs\_volumes](#output\_ebs\_volumes) | n/a |
| <a name="output_instance"></a> [instance](#output\_instance) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->