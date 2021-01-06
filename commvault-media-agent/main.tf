locals {

  instance_name = lower(join("-", [var.namespace, var.name, var.environment, var.instance_name]))

  ## TAGS
  tag_name_env         = join(":", [var.namespace, "environment"])
  tag_name_customer    = join(":", [var.namespace, "customer"])
  tag_name_application = join(":", [var.namespace, "application"])
  tag_name_hostname    = join(":", [var.namespace, "hostname"])

  common_tags = map(
    local.tag_name_env, var.environment,
    local.tag_name_customer, var.customer,
    local.tag_name_application, var.name,
    local.tag_name_hostname, var.hostname,
  )
}
## 
## EC2 Instance
##
resource "aws_instance" "commvault_media_agent" {
  ami                         = var.ec2_ami
  instance_type               = var.ec2_instance_type
  iam_instance_profile        = var.iam_instance_profile
  key_name                    = var.key_name
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.security_groups
  monitoring                  = var.enable_enhanced_monitoring
  associate_public_ip_address = var.enable_public_address
  private_ip                  = var.ec2_private_ip
  disable_api_termination     = var.termination_protection

  root_block_device {
    volume_type = var.root_volume_type
    volume_size = var.root_volume_size
    encrypted   = var.root_volume_encrypted
  }

  tags = merge(
    local.common_tags,
    map(
      "Name", local.instance_name
    )
  )
}

data "aws_subnet" "default" {
  id = var.subnet_id
}

##
## Additional EBS disk as per the ebs_disk_layouts map
##
resource "aws_ebs_volume" "default" {
  for_each          = var.ebs_disk_layouts
  availability_zone = data.aws_subnet.default.availability_zone
  size              = each.value["size"]
  type              = each.value["type"]
  encrypted         = each.value["encrypted"]

  tags = merge(
    local.common_tags,
    map(
      "Name", local.instance_name,
      join(":", [var.namespace, "ebs", "usage"]), each.value["description"],
      join(":", [var.namespace, "ebs", "attachment"]), join("/", ["/dev", each.key])
    )
  )
}

resource "aws_volume_attachment" "default" {
  for_each    = var.ebs_disk_layouts
  device_name = join("/", ["/dev", each.key])
  volume_id   = aws_ebs_volume.default[each.key].id
  instance_id = aws_instance.commvault_media_agent.id
}