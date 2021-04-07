

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
| [aws_storagegateway_nfs_file_share](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/storagegateway_nfs_file_share) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cache\_ttl | Cache time-to-live on the share when the cache is refreshed. | `string` | `"600"` | no |
| client\_list | The client CIDRs allowed to access the Storage Gateway. | `list(string)` | n/a | yes |
| customer | Customer (internal/external) Name - billing tag | `string` | n/a | yes |
| default\_storage\_class | The storage class for object placed in the bucket via the file gateway. Options: S3\_STANDARD, S3\_STANDARD\_IA, and S3\_ONEZONE\_IA. | `string` | `"S3_STANDARD"` | no |
| directory\_mode | The unix directory mode. | `string` | `"0777"` | no |
| environment | Environment - used in tagging and name generation. | `string` | `""` | no |
| file\_mode | The unix file mode. | `string` | `"0666"` | no |
| file\_share\_name | The name of the file to be created. Required if using a bucket prefix. | `string` | `null` | no |
| gateway\_arn | The Storage Gateway arn to create the file share against. | `string` | n/a | yes |
| group\_id | The default unix group id for the file share. | `string` | `"65534"` | no |
| location\_arn | The arn of the source bucket. | `string` | n/a | yes |
| name | Name or application - used in tagging and name generation | `string` | n/a | yes |
| namespace | Namespace - used in tagging and name generation. | `string` | `""` | no |
| notification\_time | The time in seconds that an upload event will be sent on a change. A 0 disables the notification. | `number` | `0` | no |
| owner\_id | The default unix owner id for the file share. | `string` | `"65534"` | no |
| region | AWS region | `string` | `"us-east-1"` | no |
| role\_arn | The rle arn that the storage gateway uses to access the bucket. | `string` | n/a | yes |
| sname | Specific name used in the nameing/tagging to distiguish multiple object of the same type. | `string` | `""` | no |
| squash | Maps a user to anonymous user. Defaults to AllSquash. Valid values: RootSquash (only root is mapped to anonymous user), NoSquash (no one is mapped to anonymous user), AllSquash (everyone is mapped to anonymous user) | `string` | `"AllSquash"` | no |

## Outputs

No output.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->