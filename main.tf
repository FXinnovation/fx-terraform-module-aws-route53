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
# Resolver endpoints inbound
#####

data "aws_subnet" "this_inbound" {
  count = "${var.enable ? var.resolver_inbound_count : 0}"

  id = "${element(var.resolver_inbound_subnet_ids[count.index], 0)}"
}

resource "aws_security_group" "this_inbound" {
  count = "${var.enable ? var.resolver_inbound_count : 0}"

  name        = "${var.resolver_inbound_security_group_name}"
  description = "Security group for inbound resolvers."
  vpc_id      = "${element(data.aws_subnet.this_inbound.*.vpc_id, count.index)}"

  tags = "${merge(
    map("Terraform", "true"),
    map("Name", var.resolver_inbound_security_group_name),
    var.tags,
    var.resolver_tags
  )}"
}

resource "aws_security_group_rule" "this_inbound_53_tcp" {
  count = "${var.enable ? var.resolver_inbound_count : 0}"

  security_group_id = "${element(aws_security_group.this_inbound.*.id, count.index)}"

  type        = "ingress"
  from_port   = 53
  to_port     = 53
  protocol    = "tcp"
  cidr_blocks = ["${var.resolver_inbound_security_group_allowed_cidrs}"]
}

resource "aws_security_group_rule" "this_inbound_53_udp" {
  count = "${var.enable ? var.resolver_inbound_count : 0}"

  security_group_id = "${element(aws_security_group.this_inbound.*.id, count.index)}"

  type        = "ingress"
  from_port   = 53
  to_port     = 53
  protocol    = "udp"
  cidr_blocks = ["${var.resolver_inbound_security_group_allowed_cidrs}"]
}

resource "aws_security_group_rule" "this_inbound_853_tcp" {
  count = "${var.enable ? var.resolver_inbound_count : 0}"

  security_group_id = "${element(aws_security_group.this_inbound.*.id, count.index)}"

  type        = "ingress"
  from_port   = 853
  to_port     = 853
  protocol    = "tcp"
  cidr_blocks = ["${var.resolver_inbound_security_group_allowed_cidrs}"]
}

resource "aws_security_group_rule" "this_inbound_853_udp" {
  count = "${var.enable ? var.resolver_inbound_count : 0}"

  security_group_id = "${element(aws_security_group.this_inbound.*.id, count.index)}"

  type        = "ingress"
  from_port   = 853
  to_port     = 853
  protocol    = "udp"
  cidr_blocks = ["${var.resolver_inbound_security_group_allowed_cidrs}"]
}

resource "aws_route53_resolver_endpoint" "this_inbound" {
  count = "${var.enable ? var.resolver_inbound_count : 0}"

  name      = "${element(var.resolver_inbound_names, count.index)}"
  direction = "INBOUND"

  security_group_ids = [
    "${element(aws_security_group.this_inbound.*.id, count.index)}",
  ]

  // This must be computed dynamically when transforming 0.11 in 0.12
  ip_address = {
    ip        = "${element(var.resolver_inbound_ip_addresses[count.index], 0)}"
    subnet_id = "${element(var.resolver_inbound_subnet_ids[count.index], 0)}"
  }

  ip_address = {
    ip        = "${element(var.resolver_inbound_ip_addresses[count.index], 1)}"
    subnet_id = "${element(var.resolver_inbound_subnet_ids[count.index], 1)}"
  }

  tags = "${merge(
    map("Terraform", "true"),
    map("Name", element(var.resolver_inbound_names, count.index)),
    var.tags,
    var.resolver_tags
  )}"
}

#####
# Resolver endpoints outbound
#####

data "aws_subnet" "this_outbound" {
  count = "${var.enable ? var.resolver_outbound_count : 0}"

  id = "${element(var.resolver_outbound_subnet_ids[count.index], 0)}"
}

resource "aws_security_group" "this_outbound" {
  count = "${var.enable ? var.resolver_outbound_count : 0}"

  name        = "${var.resolver_outbound_security_group_name}"
  description = "Security group for outbound resolvers."
  vpc_id      = "${element(data.aws_subnet.this_outbound.*.vpc_id, count.index)}"

  tags = "${merge(
    map("Terraform", "true"),
    map("Name", var.resolver_outbound_security_group_name),
    var.tags,
    var.resolver_tags
  )}"
}

resource "aws_security_group_rule" "this_outbound_53_tcp" {
  count = "${var.enable ? var.resolver_outbound_count : 0}"

  security_group_id = "${element(aws_security_group.this_outbound.*.id, count.index)}"

  type        = "ingress"
  from_port   = 53
  to_port     = 53
  protocol    = "tcp"
  cidr_blocks = ["${var.resolver_outbound_security_group_allowed_cidrs}"]
}

resource "aws_security_group_rule" "this_outbound_53_udp" {
  count = "${var.enable ? var.resolver_outbound_count : 0}"

  security_group_id = "${element(aws_security_group.this_outbound.*.id, count.index)}"

  type        = "ingress"
  from_port   = 53
  to_port     = 53
  protocol    = "udp"
  cidr_blocks = ["${var.resolver_outbound_security_group_allowed_cidrs}"]
}

resource "aws_security_group_rule" "this_outbound_853_tcp" {
  count = "${var.enable ? var.resolver_outbound_count : 0}"

  security_group_id = "${element(aws_security_group.this_outbound.*.id, count.index)}"

  type        = "ingress"
  from_port   = 853
  to_port     = 853
  protocol    = "tcp"
  cidr_blocks = ["${var.resolver_outbound_security_group_allowed_cidrs}"]
}

resource "aws_security_group_rule" "this_outbound_853_udp" {
  count = "${var.enable ? var.resolver_outbound_count : 0}"

  security_group_id = "${element(aws_security_group.this_outbound.*.id, count.index)}"

  type        = "ingress"
  from_port   = 853
  to_port     = 853
  protocol    = "udp"
  cidr_blocks = ["${var.resolver_outbound_security_group_allowed_cidrs}"]
}

resource "aws_route53_resolver_endpoint" "this_outbound" {
  count = "${var.enable ? var.resolver_outbound_count : 0}"

  name      = "${element(var.resolver_outbound_names, count.index)}"
  direction = "OUTBOUND"

  security_group_ids = [
    "${element(aws_security_group.this_outbound.*.id, count.index)}",
  ]

  // This must be computed dynamically when transforming 0.11 in 0.12
  ip_address = {
    ip        = "${element(var.resolver_outbound_ip_addresses[count.index], 0)}"
    subnet_id = "${element(var.resolver_outbound_subnet_ids[count.index], 0)}"
  }

  ip_address = {
    ip        = "${element(var.resolver_outbound_ip_addresses[count.index], 1)}"
    subnet_id = "${element(var.resolver_outbound_subnet_ids[count.index], 1)}"
  }

  tags = "${merge(
    map("Terraform", "true"),
    map("Name", element(var.resolver_outbound_names, count.index)),
    var.tags,
    var.resolver_tags
  )}"
}

#####
# Forward rules
#####

resource "aws_route53_resolver_rule" "this_forward" {
  count = "${var.enable && var.rule_forward_count > 0 ? var.rule_forward_count : 0}"

  domain_name          = "${element(var.rule_forward_domain_names, count.index)}"
  name                 = "${element(var.rule_forward_names, count.index)}"
  rule_type            = "FORWARD"
  resolver_endpoint_id = "${element(concat(var.rule_forward_resolver_endpoint_ids, list("")), 0) != "" ? element(concat(var.rule_forward_resolver_endpoint_ids, list("")), count.index) : element(concat(aws_route53_resolver_endpoint.this_outbound.*.id, list("")), 0)}"

  target_ip = [
    "${var.rule_forward_resolver_target_ips[count.index]}",
  ]

  tags = "${merge(
    map("Terraform", "true"),
    map("Name", element(var.rule_forward_names, count.index)),
    var.tags,
    var.rule_forward_tags
  )}"
}

resource "aws_route53_resolver_rule_association" "this_forward" {
  count = "${var.enable && var.rule_forward_count > 0 ? (var.rule_forward_vpc_attachement_count + 1) * var.rule_forward_count : 0}"

  resolver_rule_id = "${element(aws_route53_resolver_rule.this_forward.*.id, count.index % var.rule_forward_count)}"
  vpc_id           = "${element(concat(list(var.vpc_id), var.rule_forward_vpc_attachement_ids), floor(count.index / var.rule_forward_count) % (var.rule_forward_vpc_attachement_count + 1))}"
}

#####
# Records
#####

locals {
  zone_ids   = "${compact(concat(aws_route53_zone.this_private.*.zone_id, aws_route53_zone.this_public.*.zone_id))}"
  zone_names = "${compact(concat(aws_route53_zone.this_private.*.name, aws_route53_zone.this_public.*.name))}"
}
