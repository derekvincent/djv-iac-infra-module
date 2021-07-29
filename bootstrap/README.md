#Remote S3 State Bootstrap 

## Overview 

This module is used to create the initial S3 Remote bucket and DynamoDB lock table. 

A role and policy will be created for that can be used to assign to users who need to access the state to run the terraform. 

### Bucket 

The bucket has **versioning enabled**, and currently only uses bucket **AES256 encryption** (it currently does not support KMS). The following default lifecycle policy - the _non current version_ moves to *STANDARD_IA* after **30** days and then *GLACIER* after **90**. It is is never deleted. 


### DynamoDB 

A table is created with the LockId key field to be used to lock the states files stored in the S3 state bucket. Currently only the **PAY_PER_REQUEST** is used for the billing method. 


### Not Current Supported
-[] KMS for buckets 
-[] Bucket replication 
-[] Detailed lifecycle policies 
-[] 


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_local"></a> [local](#provider\_local) | n/a |
| <a name="provider_template"></a> [template](#provider\_template) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_dynamodb_table.terraform_lock](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |
| [aws_iam_policy.terraform_state](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_s3_bucket.terraform_state](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_public_access_block.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [local_file.terraform_backend_config](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [template_file.terraform_backend_config](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_customer"></a> [customer](#input\_customer) | Customer Name - billing tag | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment - eg. 'sbx', 'dev','qa','prod' | `string` | `""` | no |
| <a name="input_glacier_days"></a> [glacier\_days](#input\_glacier\_days) | Number of days before non current versions are moved to Glacier. Default: 90 | `number` | `90` | no |
| <a name="input_lifecycle_prefix"></a> [lifecycle\_prefix](#input\_lifecycle\_prefix) | Use this to set the prefix used by the lifecycle policy, if not used then entire bucket is set. Ensure all states are in that prefix. | `any` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Name | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace - 'clk' or 'clklab' | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | `"us-east-1"` | no |
| <a name="input_standard_ia_days"></a> [standard\_ia\_days](#input\_standard\_ia\_days) | Number of days before non current versions are moved to Standard IA. Default: 30 | `number` | `30` | no |
| <a name="input_state_bucket_name"></a> [state\_bucket\_name](#input\_state\_bucket\_name) | Use this to override the default bucket name <namespace>-<name>-<environment>-terraform-state | `any` | `null` | no |
| <a name="input_state_policy_name"></a> [state\_policy\_name](#input\_state\_policy\_name) | Use this to override the default policy name <namespace>-<name>-<environment>-remote-state-policy | `string` | `null` | no |
| <a name="input_state_table_name"></a> [state\_table\_name](#input\_state\_table\_name) | Use this to override the default table name <namespace>-<name>-<environment>-remote-state | `string` | `null` | no |
| <a name="input_terraform_state_file"></a> [terraform\_state\_file](#input\_terraform\_state\_file) | The path to the state file inside the bucket | `string` | `"global/s3state/terraform.tfstate"` | no |
| <a name="input_terraform_version"></a> [terraform\_version](#input\_terraform\_version) | The minimum required terraform version | `string` | `"0.13"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_state_bucket_arn"></a> [state\_bucket\_arn](#output\_state\_bucket\_arn) | S3 state arn |
| <a name="output_state_bucket_id"></a> [state\_bucket\_id](#output\_state\_bucket\_id) | S3 state bucket id |
| <a name="output_state_bucket_name"></a> [state\_bucket\_name](#output\_state\_bucket\_name) | S3 state bucket domain name |
| <a name="output_state_lock_table_arn"></a> [state\_lock\_table\_arn](#output\_state\_lock\_table\_arn) | DynamoDB locak table arn |
| <a name="output_state_lock_table_id"></a> [state\_lock\_table\_id](#output\_state\_lock\_table\_id) | DynamoDB locak table id |
| <a name="output_state_lock_table_name"></a> [state\_lock\_table\_name](#output\_state\_lock\_table\_name) | DynamoDB locak table name |
| <a name="output_state_policy_arn"></a> [state\_policy\_arn](#output\_state\_policy\_arn) | Terraform State policy. |
| <a name="output_state_policy_id"></a> [state\_policy\_id](#output\_state\_policy\_id) | Terraform State policy. |
| <a name="output_state_policy_name"></a> [state\_policy\_name](#output\_state\_policy\_name) | Terraform State policy. |
| <a name="output_terraform_backend_config"></a> [terraform\_backend\_config](#output\_terraform\_backend\_config) | Rendered Terraform backend config file |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
