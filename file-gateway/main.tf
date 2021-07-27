locals {

  name                = var.sname != "" ? lower(join("-", ["file-gateway", var.sname])) : "file-gateway"
  instance_name       = lower(join("-", [var.namespace, var.name, var.environment, local.name]))
  security_group_name = lower(join("-", [local.instance_name, "sgw"]))

  ## TAGS
  tag_name_env         = join(":", [var.namespace, "environment"])
  tag_name_customer    = join(":", [var.namespace, "customer"])
  tag_name_application = join(":", [var.namespace, "application"])
  tag_name_hostname    = join(":", [var.namespace, "hostname"])

  common_tags = map(
    local.tag_name_env, var.environment,
    local.tag_name_customer, var.customer,
    local.tag_name_application, var.name,
  )

  ## Ingress 
  admin_access = {
    "http_admin" : {
      from_port : "80",
      to_port : "80",
      protocol : "TCP",
      cidr_blocks : var.admin_cidrs,
      description : "HTTP Admin Access"
    },
    "https_admin" : {
      from_port : "443",
      to_port : "443",
      protocol : "TCP",
      cidr_blocks : var.admin_cidrs,
      description : "HTTPS Admin Access"
    }
  }

  active_directory = length(var.ads_cidrs) > 0 ? {
    "ads_admin" : {
      from_port : "137",
      to_port : "138",
      protocol : "TCP",
      cidr_blocks : var.ads_cidrs,
      description : "Active Directory"
    },
    "ads_ldap_admin" : {
      from_port : "389",
      to_port : "389",
      protocol : "TCP",
      cidr_blocks : var.ads_cidrs,
      description : "Active Directory LDAP"
    },
    "ads_ldaps_admin" : {
      from_port : "636",
      to_port : "636",
      protocol : "TCP",
      cidr_blocks : var.ads_cidrs,
      description : "Active Directory LDAPS"
    }
  } : {}

  nfs_v4_access = length(var.nfs_cidrs) > 0 ? {
    "nfs_2049" : {
      from_port : "2049",
      to_port : "2049",
      protocol : "TCP",
      cidr_blocks : var.nfs_cidrs,
      description : "NFS V4"
    }
  } : {}

  nfs_v3_access = length(var.nfs_cidrs) > 0 && var.enable_nfs_v3 ? {
    "nfs_111" : {
      from_port : "111",
      to_port : "111",
      protocol : "TCP",
      cidr_blocks : var.nfs_cidrs,
      description : "NFS V3"
    },
    "nfs_20048" : {
      from_port : "20048",
      to_port : "20048",
      protocol : "TCP",
      cidr_blocks : var.nfs_cidrs,
      description : "NFS V3"
    }
  } : {}

  smb_access = length(var.smb_cidrs) > 0 ? {
    "smb" : {
      from_port : "445",
      to_port : "445",
      protocol : "TCP",
      cidr_blocks : var.smb_cidrs,
      description : "SMB"
    }
  } : {}

  ## Egress
  dns_access = {
    "dns_access" : {
      from_port : "53",
      to_port : "53",
      protocol : "TCP",
      cidr_blocks : var.dns_cidrs,
      description : "DNS Access"
    }
  }

  ## This need internet access
  ntp_access = {
    "ntp_access" : {
      from_port : "123",
      to_port : "123",
      protocol : "TCP",
      cidr_blocks : ["0.0.0.0/0"],
      description : "NTP Access"
    }
  }

  http_internet_access = {
    "http_internet" : {
      from_port : "80",
      to_port : "80",
      protocol : "TCP",
      cidr_blocks : ["0.0.0.0/0"],
      description : "HTTP Internet Access - Software Updates"
    },
    "https_internet" : {
      from_port : "443",
      to_port : "443",
      protocol : "TCP",
      cidr_blocks : ["0.0.0.0/0"],
      description : "HTTPS Internet Access - Software Updates and S3"
    }
  }

  active_directory_egress = length(var.ads_cidrs) > 0 ? {
    "ads_admin" : {
      from_port : "137",
      to_port : "138",
      protocol : "TCP",
      cidr_blocks : var.ads_cidrs,
      description : "Active Directory"
    },
    "ads_ldap_admin" : {
      from_port : "389",
      to_port : "389",
      protocol : "TCP",
      cidr_blocks : var.ads_cidrs,
      description : "Active Directory LDAP"
    },
    "ads_ldaps_admin" : {
      from_port : "636",
      to_port : "636",
      protocol : "TCP",
      cidr_blocks : var.ads_cidrs,
      description : "Active Directory LDAPS"
    }
  } : {}

  ingress_map = merge(local.admin_access, local.active_directory, local.nfs_v4_access,
  local.nfs_v3_access, local.smb_access)

  egress_map = merge(local.dns_access, local.ntp_access, local.http_internet_access,
  local.active_directory_egress)
}

data "aws_ssm_parameter" "latest_ec2" {
  name = "/aws/service/storagegateway/ami/FILE_S3/latest"
}

resource "aws_security_group" "file_gateway" {
  name        = local.security_group_name
  description = "File Gateway Security Group"
  vpc_id      = var.vpc_id

  tags = merge(
    local.common_tags,
    map(
      "Name", local.security_group_name
    )
  )
}

resource "aws_security_group_rule" "ingress" {
  for_each          = local.ingress_map
  type              = "ingress"
  from_port         = lookup(each.value, "from_port")
  to_port           = lookup(each.value, "to_port")
  protocol          = lookup(each.value, "protocol")
  cidr_blocks       = lookup(each.value, "cidr_blocks", null)
  description       = lookup(each.value, "description", "")
  security_group_id = aws_security_group.file_gateway.id
}

resource "aws_security_group_rule" "egress" {
  for_each          = local.egress_map
  type              = "egress"
  from_port         = lookup(each.value, "from_port")
  to_port           = lookup(each.value, "to_port")
  protocol          = lookup(each.value, "protocol")
  cidr_blocks       = lookup(each.value, "cidr_blocks", null)
  description       = lookup(each.value, "description", "")
  security_group_id = aws_security_group.file_gateway.id
}




resource "aws_instance" "file_gateway" {
  #tfsec:ignore:AWS079
  ami                         = data.aws_ssm_parameter.latest_ec2.value
  instance_type               = var.ec2_instance_type
  iam_instance_profile        = aws_iam_instance_profile.file_gateway.name
  key_name                    = var.key_name
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.file_gateway.id]
  monitoring                  = var.enable_enhanced_monitoring
  associate_public_ip_address = false
  ebs_optimized               = true

  root_block_device {
    volume_type = var.root_volume_type
    volume_size = var.root_volume_size
    encrypted   = var.root_volume_encrypted
  }

  tags = merge(
    local.common_tags,
    map(
      "Name", local.instance_name,
      local.tag_name_hostname, join(".", [var.gateway_name, var.gateway_domain]),
    )
  )

  lifecycle {
    ignore_changes = [ami] ## If the latest AMI change we do not want to redeploy a new instance.
  }
}

data "aws_subnet" "default" {
  id = var.subnet_id
}

##
## Cache EBS 
##
resource "aws_ebs_volume" "cache" {
  availability_zone = data.aws_subnet.default.availability_zone
  size              = var.cache_volume_size
  type              = var.cache_volume_type
  encrypted         = var.cache_volume_encrypted

  tags = merge(
    local.common_tags,
    map(
      "Name", local.instance_name,
      join(":", [var.namespace, "ebs", "usage"]), "cache",
      join(":", [var.namespace, "ebs", "attachment"]), "/dev/xvdf",
      local.tag_name_hostname, join(".", [var.gateway_name, var.gateway_domain]),
    )
  )
}

resource "aws_volume_attachment" "cache" {
  device_name = "/dev/xvdf"
  volume_id   = aws_ebs_volume.cache.id
  instance_id = aws_instance.file_gateway.id
}

##
## Storage Gateway Activation 
##

resource "aws_storagegateway_gateway" "file_gateway" {
  gateway_ip_address = aws_instance.file_gateway.private_ip
  gateway_name       = var.gateway_name
  gateway_timezone   = var.gateway_time_zone
  gateway_type       = "FILE_S3"
}

data "aws_storagegateway_local_disk" "cache" {
  disk_path   = aws_volume_attachment.cache.device_name
  disk_node   = aws_volume_attachment.cache.device_name
  gateway_arn = aws_storagegateway_gateway.file_gateway.id
}

resource "aws_storagegateway_cache" "cache_volume" {
  disk_id     = data.aws_storagegateway_local_disk.cache.id
  gateway_arn = aws_storagegateway_gateway.file_gateway.id
}