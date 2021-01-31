#Remote S3 State Bootstrap 

## Overview 

This module is used to create the inital S3 Remote bucket and DynamoDB lock table. 

A role and policy will be created for that can be used to asign to users who need to access the state to run the terraform. 

### Bucket 

The bucket has **versioning enabled**, and currently only uses bucket **AES256 encryption** (it currently does not support KMS). The following default lifecycle policy - the _non current version_ moves to *STANDARD_IA* after **30** days and then *GLACIER* after **90**. It is is never deleted. 


### DynamoDB 

A table is created with the LockId key field to be used to lock the states files stored in the S3 state bucket. Currently only the **PAY_PER_REQUEST** is used for the billing method. 


### Not Current Supported
-[] KMS for buckets 
-[] Bucket replication 
-[] Detailed lifcycle policies 
-[] 


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |
| local | n/a |
| template | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| customer | Customer Name - billing tag | `string` | n/a | yes |
| environment | Environment - eg. 'sbx', 'dev','qa','prod' | `string` | `""` | no |
| glacier\_days | Number of days before non current versions are moved to Glacier. Default: 90 | `number` | `90` | no |
| lifecycle\_prefix | Use this to set the prefix used by the lifecycle policy, if not used then entire bucket is set. Ensure all states are in that prefix. | `any` | `null` | no |
| name | Name | `string` | n/a | yes |
| namespace | Namespace - 'clk' or 'clklab' | `string` | `""` | no |
| region | AWS region | `string` | `"us-east-1"` | no |
| standard\_ia\_days | Number of days before non current versions are moved to Standard IA. Default: 30 | `number` | `30` | no |
| state\_bucket\_name | Use this to override the default bucket name <namespace>-<name>-<environment>-terraform-state | `any` | `null` | no |
| state\_policy\_name | Use this to override the default policy name <namespace>-<name>-<environment>-remote-state-policy | `string` | `null` | no |
| state\_table\_name | Use this to override the default table name <namespace>-<name>-<environment>-remote-state | `string` | `null` | no |
| terraform\_state\_file | The path to the state file inside the bucket | `string` | `"global/s3state/terraform.tfstate"` | no |
| terraform\_version | The minimum required terraform version | `string` | `"0.13"` | no |

## Outputs

| Name | Description |
|------|-------------|
| state\_bucket\_arn | S3 state arn |
| state\_bucket\_id | S3 state bucket id |
| state\_bucket\_name | S3 state bucket domain name |
| state\_lock\_table\_arn | DynamoDB locak table arn |
| state\_lock\_table\_id | DynamoDB locak table id |
| state\_lock\_table\_name | DynamoDB locak table name |
| state\_policy\_arn | Terraform State policy. |
| state\_policy\_id | Terraform State policy. |
| state\_policy\_name | Terraform State policy. |
| terraform\_backend\_config | Rendered Terraform backend config file |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
