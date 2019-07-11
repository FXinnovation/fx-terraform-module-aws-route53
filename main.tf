#####
# Hosted zone
#####

resource "aws_route53_zone" "this_public" {
  count = "${var.enable ? var.zone_public_count : 0}"

  name    = "${element(var.zone_public_names, count.index)}"
  comment = "${element(var.zone_public_comments, count.index)}"

  tags = "${merge(
    map("Terraform", "true"),
    map("Name", element(var.zone_public_names, count.index)),
    var.tags,
    var.zone_tags
  )}"
}

resource "aws_route53_zone" "this_private" {
  count = "${var.enable ? var.zone_private_count : 0}"

  name    = "${element(var.zone_private_names, count.index)}"
  comment = "${element(var.zone_private_comments, count.index)}"

  vpc {
    vpc_id = "${var.vpc_id}"
  }

  lifecycle {
    ignore_changes = ["vpc"]
  }

  tags = "${merge(
    map("Terraform", "true"),
    map("Name", element(var.zone_private_names, count.index)),
    var.tags,
    var.zone_tags
  )}"
}

resource "aws_route53_zone_association" "this_private" {
  count = "${var.enable ? var.zone_private_vpc_attachement_count * var.zone_private_count : 0}"

  zone_id = "${element(aws_route53_zone.this_private.*.id, count.index % var.zone_private_count)}"
  vpc_id  = "${element(var.zone_private_vpc_attachement_ids, floor(count.index / var.zone_private_count) % var.zone_private_vpc_attachement_count)}"
}

#####
# Resolver endpoints
#####

resource "aws_security_group" "this_inbound" {
  count = "${var.enable && var.resolver_inbound_count > 1 ? 1 : 0}"

  name        = "${var.resolver_inbound_security_group_name}"
  description = "Security group for inbound resolvers."
  vpc_id      = "${var.vpc_id}"

  tags = "${merge(
    map("Terraform", "true"),
    map("Name", var.resolver_inbound_security_group_name),
    var.tags,
    var.resolver_tags
  )}"
}

resource "aws_security_group_rule" "this_inbound_53_tcp" {
  count = "${var.enable && var.resolver_inbound_count > 1 ? 1 : 0}"

  security_group_id = "${element(concat(aws_security_group.this_inbound.*.id, list("")), 0)}"

  type        = "ingress"
  from_port   = 53
  to_port     = 53
  protocol    = "tcp"
  cidr_blocks = ["${var.resolver_inbound_security_group_allowed_cidrs}"]
}

resource "aws_security_group_rule" "this_inbound_53_udp" {
  count = "${var.enable && var.resolver_inbound_count > 1 ? 1 : 0}"

  security_group_id = "${element(concat(aws_security_group.this_inbound.*.id, list("")), 0)}"

  type        = "ingress"
  from_port   = 53
  to_port     = 53
  protocol    = "udp"
  cidr_blocks = ["${var.resolver_inbound_security_group_allowed_cidrs}"]
}

resource "aws_security_group_rule" "this_inbound_853_tcp" {
  count = "${var.enable && var.resolver_inbound_count > 1 ? 1 : 0}"

  security_group_id = "${element(concat(aws_security_group.this_inbound.*.id, list("")), 0)}"

  type        = "ingress"
  from_port   = 853
  to_port     = 853
  protocol    = "tcp"
  cidr_blocks = ["${var.resolver_inbound_security_group_allowed_cidrs}"]
}

resource "aws_security_group_rule" "this_inbound_853_udp" {
  count = "${var.enable && var.resolver_inbound_count > 1 ? 1 : 0}"

  security_group_id = "${element(concat(aws_security_group.this_inbound.*.id, list("")), 0)}"

  type        = "ingress"
  from_port   = 853
  to_port     = 853
  protocol    = "udp"
  cidr_blocks = ["${var.resolver_inbound_security_group_allowed_cidrs}"]
}

locals {
  // These must go away once the module is adapted from  0.11 to Terraform 0.12
  this_inbound_ip_address1 = "${element(var.resolver_inbound_ip_addresses[0], 0)}"
  this_inbound_ip_address2 = "${element(var.resolver_inbound_ip_addresses[0], 1)}"
  this_inbound_subnet_id1  = "${element(var.resolver_inbound_subnet_ids[0], 0)}"
  this_inbound_subnet_id2  = "${element(var.resolver_inbound_subnet_ids[0], 1)}"
}

resource "aws_route53_resolver_endpoint" "this_inbound" {
  count = "${var.enable ? var.resolver_inbound_count : 0}"

  name      = "${element(var.resolver_inbound_names, count.index)}"
  direction = "INBOUND"

  security_group_ids = [
    "${aws_security_group.this_inbound.id}",
  ]

  // This must be computed automatically when transforming 0.11 in 0.12
  ip_address = {
    ip        = "${local.this_inbound_ip_address1}"
    subnet_id = "${local.this_inbound_subnet_id1}"
  }

  ip_address = {
    ip        = "${local.this_inbound_ip_address2}"
    subnet_id = "${local.this_inbound_subnet_id2}"
  }

  tags = "${merge(
    map("Terraform", "true"),
    map("Name", element(var.resolver_inbound_names, count.index)),
    var.tags,
    var.resolver_tags
  )}"
}

#####
# Records
#####

locals {
  zone_ids   = "${compact(concat(aws_route53_zone.this_private.*.zone_id, aws_route53_zone.this_public.*.zone_id))}"
  zone_names = "${compact(concat(aws_route53_zone.this_private.*.name, aws_route53_zone.this_public.*.name))}"
}
