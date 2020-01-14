data "aws_route53_zone" "this_private" {
  count = var.enable ? var.zone_private_count : 0

  zone_id = element(concat(var.zone_private_ids, [""]), 0) == "" ? element(concat(aws_route53_zone.this_private.*.id, [""]), 0) : element(concat(var.zone_private_ids, [""]), count.index)
}

data "aws_subnet" "this_inbound" {
  count = var.enable ? var.resolver_inbound_count : 0

  id = element(var.resolver_inbound_subnet_ids[count.index], 0)
}

data "aws_subnet" "this_outbound" {
  count = var.enable ? var.resolver_outbound_count : 0

  id = element(var.resolver_outbound_subnet_ids[count.index], 0)
}
