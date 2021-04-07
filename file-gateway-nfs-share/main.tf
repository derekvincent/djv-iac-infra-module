locals {

  share_name = lower(join("-", [var.namespace, var.name, var.environment, trimprefix(trimprefix(var.file_share_name, var.environment), "-"), "nfs-share"]))

  notification_policy = var.notification_time == 0 ? jsonencode({ "Upload" : { "SettlingTimeInSeconds" : var.notification_time } }) : "{}"

  ## TAGS
  tag_name_env         = join(":", [var.namespace, "environment"])
  tag_name_customer    = join(":", [var.namespace, "customer"])
  tag_name_application = join(":", [var.namespace, "application"])

  common_tags = map(
    local.tag_name_env, var.environment,
    local.tag_name_customer, var.customer,
    local.tag_name_application, var.name,
  )
}

resource "aws_storagegateway_nfs_file_share" "shares" {
  client_list             = var.client_list
  gateway_arn             = var.gateway_arn
  location_arn            = var.location_arn
  role_arn                = var.role_arn
  file_share_name         = var.file_share_name
  default_storage_class   = var.default_storage_class
  guess_mime_type_enabled = true
  squash                  = var.squash
  notification_policy     = local.notification_policy

  nfs_file_share_defaults {
    directory_mode = var.directory_mode
    file_mode      = var.file_mode
    group_id       = var.group_id
    owner_id       = var.owner_id
  }

  cache_attributes {
    cache_stale_timeout_in_seconds = var.cache_ttl
  }

  tags = merge(
    local.common_tags,
    map(
      "Name", local.share_name
    )
  )
}