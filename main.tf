#####
# Hosted zone
#####

resource "aws_route53_zone" "this_public" {
  count = var.enable ? var.zone_public_count : 0

  name    = element(var.zone_public_names, count.index)
  comment = element(var.zone_public_comments, count.index)

  tags = merge(
    {
      "Terraform" = "true"
    },
    {
      "Name" = element(var.zone_public_names, count.index)
    },
    var.tags,
    var.zone_tags,
  )
}

resource "aws_route53_zone" "this_private" {
  count = var.enable && var.zone_private_ids_count == 0 ? var.zone_private_count : 0

  name    = element(var.zone_private_names, count.index)
  comment = element(var.zone_private_comments, count.index)

  vpc {
    vpc_id = var.vpc_id
  }

  lifecycle {
    ignore_changes = [vpc]
  }

  tags = merge(
    {
      "Terraform" = "true"
    },
    {
      "Name" = element(var.zone_private_names, count.index)
    },
    var.tags,
    var.zone_tags,
  )
}

resource "aws_route53_zone_association" "this_private" {
  count = var.enable ? var.zone_private_vpc_attachement_count * var.zone_private_count : 0

  zone_id = element(
    data.aws_route53_zone.this_private.*.id,
    count.index % var.zone_private_count,
  )
  vpc_id = element(
    var.zone_private_vpc_attachement_ids,
    floor(count.index / var.zone_private_count) % var.zone_private_vpc_attachement_count,
  )
}

#####
# Resolver endpoints inbound
#####

resource "aws_route53_resolver_endpoint" "this_inbound" {
  count = var.enable ? var.resolver_inbound_count : 0

  name      = element(var.resolver_inbound_names, count.index)
  direction = "INBOUND"

  security_group_ids = [
    element(aws_security_group.this_inbound.*.id, count.index),
  ]

  // This must be computed dynamically when transforming 0.11 in 0.12
  ip_address {
    ip        = element(var.resolver_inbound_ip_addresses[count.index], 0)
    subnet_id = element(var.resolver_inbound_subnet_ids[count.index], 0)
  }

  ip_address {
    ip        = element(var.resolver_inbound_ip_addresses[count.index], 1)
    subnet_id = element(var.resolver_inbound_subnet_ids[count.index], 1)
  }

  tags = merge(
    {
      "Terraform" = "true"
    },
    {
      "Name" = element(var.resolver_inbound_names, count.index)
    },
    var.tags,
    var.resolver_tags,
  )
}

#####
# Resolver endpoints outbound
#####

resource "aws_route53_resolver_endpoint" "this_outbound" {
  count = var.enable ? var.resolver_outbound_count : 0

  name      = element(var.resolver_outbound_names, count.index)
  direction = "OUTBOUND"

  security_group_ids = [
    element(aws_security_group.this_outbound.*.id, count.index),
  ]

  // This must be computed dynamically when transforming 0.11 in 0.12
  ip_address {
    ip        = element(var.resolver_outbound_ip_addresses[count.index], 0)
    subnet_id = element(var.resolver_outbound_subnet_ids[count.index], 0)
  }

  ip_address {
    ip        = element(var.resolver_outbound_ip_addresses[count.index], 1)
    subnet_id = element(var.resolver_outbound_subnet_ids[count.index], 1)
  }

  tags = merge(
    {
      "Terraform" = "true"
    },
    {
      "Name" = element(var.resolver_outbound_names, count.index)
    },
    var.tags,
    var.resolver_tags,
  )
}

#####
# Forward rules
#####

resource "aws_route53_resolver_rule" "this_forward" {
  count = var.enable && var.rule_forward_count > 0 && var.rule_forward_attachement_ids_count == 0 ? var.rule_forward_count : 0

  domain_name = element(var.rule_forward_domain_names, count.index)
  name        = element(var.rule_forward_names, count.index)
  rule_type   = "FORWARD"
  resolver_endpoint_id = element(concat(var.rule_forward_resolver_endpoint_ids, [""]), 0) != "" ? element(
    concat(var.rule_forward_resolver_endpoint_ids, [""]),
    count.index,
    ) : element(
    concat(aws_route53_resolver_endpoint.this_outbound.*.id, [""]),
    0,
  )

  dynamic "target_ip" {
    for_each = [var.rule_forward_resolver_target_ips[count.index]]
    content {
      ip   = target_ip.value
    }
  }

  tags = merge(
    {
      "Terraform" = "true"
    },
    {
      "Name" = element(var.rule_forward_names, count.index)
    },
    var.tags,
    var.rule_forward_tags,
  )
}

resource "aws_route53_resolver_rule_association" "this_forward" {
  count = var.enable && var.rule_forward_count > 0 ? var.rule_forward_vpc_attachement_count * var.rule_forward_count : 0

  resolver_rule_id = element(concat(var.rule_forward_attachement_ids, [""]), 0) == "" ? element(
    concat(aws_route53_resolver_rule.this_forward.*.id, [""]),
    count.index % var.rule_forward_count,
    ) : element(
    concat(var.rule_forward_attachement_ids, [""]),
    count.index % var.rule_forward_count,
  )
  vpc_id = element(
    concat(var.rule_forward_vpc_attachement_ids),
    floor(count.index / var.rule_forward_count) % var.rule_forward_vpc_attachement_count,
  )
}

#####
# Resource share
#####

resource "aws_ram_resource_share" "this_forward" {
  count = var.enable && length(var.rule_forward_share_indexes) > 0 ? length(var.rule_forward_share_indexes) : 0

  name                      = element(var.rule_forward_share_names, count.index)
  allow_external_principals = true

  tags = merge(
    {
      "Terraform" = "true"
    },
    {
      "Name" = element(var.rule_forward_share_names, count.index)
    },
    var.tags,
    var.rule_forward_share_tags,
  )
}

resource "aws_ram_resource_association" "this_forward" {
  count = var.enable && length(var.rule_forward_share_indexes) > 0 ? length(var.rule_forward_share_indexes) : 0

  resource_arn = element(
    aws_route53_resolver_rule.this_forward.*.arn,
    element(var.rule_forward_share_indexes, count.index),
  )
  resource_share_arn = element(aws_ram_resource_share.this_forward.*.arn, count.index)
}

resource "aws_ram_principal_association" "this_forward" {
  count = var.enable && length(var.rule_forward_share_indexes) > 0 && var.rule_forward_share_principal_count > 0 ? length(var.rule_forward_share_indexes) * var.rule_forward_share_principal_count : 0

  principal = element(
    var.rule_forward_share_principals,
    count.index % var.rule_forward_share_principal_count,
  )
  resource_share_arn = element(
    aws_ram_resource_share.this_forward.*.arn,
    floor(count.index / var.rule_forward_share_principal_count) % length(var.rule_forward_share_indexes),
  )
}

#####
# Records
#####

locals {
  zone_ids = compact(
    concat(
      data.aws_route53_zone.this_private.*.zone_id,
      aws_route53_zone.this_public.*.zone_id,
    ),
  )
  zone_names = compact(
    concat(
      data.aws_route53_zone.this_private.*.name,
      aws_route53_zone.this_public.*.name,
    ),
  )
}

resource "aws_route53_record" "this" {
  count = var.enable && length(var.record_zone_indexes) > 0 ? length(var.record_zone_indexes) : 0

  zone_id = element(
    concat(local.zone_ids, [""]),
    element(var.record_zone_indexes, count.index),
  )
  name = element(concat(var.record_domain_names, [""]), count.index)
  type = element(concat(var.record_types, [""]), count.index)
  ttl  = element(concat(var.record_ttls, [""]), count.index)
  records         = [var.record_records[count.index]]
  allow_overwrite = true
}

resource "aws_route53_record" "this_alias" {
  count = var.enable && length(var.record_alias_zone_indexes) > 0 ? length(var.record_alias_zone_indexes) : 0

  zone_id = element(
    concat(local.zone_ids, [""]),
    element(concat(var.record_alias_zone_indexes, [""]), count.index),
  )
  name = element(
    concat(var.record_alias_domain_names, [""]),
    element(var.record_alias_zone_indexes, count.index),
  )
  type            = element(concat(var.record_alias_types, [""]), count.index)
  allow_overwrite = true

  alias {
    name                   = element(concat(var.record_alias_dns_names, [""]), count.index)
    zone_id                = element(concat(var.record_alias_zone_id, [""]), count.index)
    evaluate_target_health = element(concat(var.record_alias_evaluate_healths, [""]), count.index)
  }
}

