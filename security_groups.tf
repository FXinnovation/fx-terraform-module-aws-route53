#####
# Resolver security group inbound
#####

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
  cidr_blocks = ["${var.resolver_inbound_security_group_ingress_allowed_cidrs}"]
}

resource "aws_security_group_rule" "this_inbound_53_udp" {
  count = "${var.enable ? var.resolver_inbound_count : 0}"

  security_group_id = "${element(aws_security_group.this_inbound.*.id, count.index)}"

  type        = "ingress"
  from_port   = 53
  to_port     = 53
  protocol    = "udp"
  cidr_blocks = ["${var.resolver_inbound_security_group_ingress_allowed_cidrs}"]
}

resource "aws_security_group_rule" "this_inbound_853_tcp" {
  count = "${var.enable ? var.resolver_inbound_count : 0}"

  security_group_id = "${element(aws_security_group.this_inbound.*.id, count.index)}"

  type        = "ingress"
  from_port   = 853
  to_port     = 853
  protocol    = "tcp"
  cidr_blocks = ["${var.resolver_inbound_security_group_ingress_allowed_cidrs}"]
}

resource "aws_security_group_rule" "this_inbound_853_udp" {
  count = "${var.enable ? var.resolver_inbound_count : 0}"

  security_group_id = "${element(aws_security_group.this_inbound.*.id, count.index)}"

  type        = "ingress"
  from_port   = 853
  to_port     = 853
  protocol    = "udp"
  cidr_blocks = ["${var.resolver_inbound_security_group_ingress_allowed_cidrs}"]
}

resource "aws_security_group_rule" "this_inbound_out_53_tcp" {
  count = "${var.enable ? var.resolver_inbound_count : 0}"

  security_group_id = "${element(aws_security_group.this_inbound.*.id, count.index)}"

  type        = "egress"
  from_port   = 53
  to_port     = 53
  protocol    = "tcp"
  cidr_blocks = ["${var.resolver_inbound_security_group_egress_allowed_cidrs}"]
}

resource "aws_security_group_rule" "this_inbound_out_53_udp" {
  count = "${var.enable ? var.resolver_inbound_count : 0}"

  security_group_id = "${element(aws_security_group.this_inbound.*.id, count.index)}"

  type        = "egress"
  from_port   = 53
  to_port     = 53
  protocol    = "udp"
  cidr_blocks = ["${var.resolver_inbound_security_group_egress_allowed_cidrs}"]
}

resource "aws_security_group_rule" "this_inbound_out_853_tcp" {
  count = "${var.enable ? var.resolver_inbound_count : 0}"

  security_group_id = "${element(aws_security_group.this_inbound.*.id, count.index)}"

  type        = "egress"
  from_port   = 853
  to_port     = 853
  protocol    = "tcp"
  cidr_blocks = ["${var.resolver_inbound_security_group_egress_allowed_cidrs}"]
}

resource "aws_security_group_rule" "this_inbound_out_853_udp" {
  count = "${var.enable ? var.resolver_inbound_count : 0}"

  security_group_id = "${element(aws_security_group.this_inbound.*.id, count.index)}"

  type        = "egress"
  from_port   = 853
  to_port     = 853
  protocol    = "udp"
  cidr_blocks = ["${var.resolver_inbound_security_group_egress_allowed_cidrs}"]
}

#####
# Resolver security group outbound
#####

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
  cidr_blocks = ["${var.resolver_outbound_security_group_ingress_allowed_cidrs}"]
}

resource "aws_security_group_rule" "this_outbound_53_udp" {
  count = "${var.enable ? var.resolver_outbound_count : 0}"

  security_group_id = "${element(aws_security_group.this_outbound.*.id, count.index)}"

  type        = "ingress"
  from_port   = 53
  to_port     = 53
  protocol    = "udp"
  cidr_blocks = ["${var.resolver_outbound_security_group_ingress_allowed_cidrs}"]
}

resource "aws_security_group_rule" "this_outbound_853_tcp" {
  count = "${var.enable ? var.resolver_outbound_count : 0}"

  security_group_id = "${element(aws_security_group.this_outbound.*.id, count.index)}"

  type        = "ingress"
  from_port   = 853
  to_port     = 853
  protocol    = "tcp"
  cidr_blocks = ["${var.resolver_outbound_security_group_ingress_allowed_cidrs}"]
}

resource "aws_security_group_rule" "this_outbound_853_udp" {
  count = "${var.enable ? var.resolver_outbound_count : 0}"

  security_group_id = "${element(aws_security_group.this_outbound.*.id, count.index)}"

  type        = "ingress"
  from_port   = 853
  to_port     = 853
  protocol    = "udp"
  cidr_blocks = ["${var.resolver_outbound_security_group_ingress_allowed_cidrs}"]
}

resource "aws_security_group_rule" "this_outbound_out_53_tcp" {
  count = "${var.enable ? var.resolver_outbound_count : 0}"

  security_group_id = "${element(aws_security_group.this_outbound.*.id, count.index)}"

  type        = "egress"
  from_port   = 53
  to_port     = 53
  protocol    = "tcp"
  cidr_blocks = ["${var.resolver_outbound_security_group_egress_allowed_cidrs}"]
}

resource "aws_security_group_rule" "this_outbound_out_53_udp" {
  count = "${var.enable ? var.resolver_outbound_count : 0}"

  security_group_id = "${element(aws_security_group.this_outbound.*.id, count.index)}"

  type        = "egress"
  from_port   = 53
  to_port     = 53
  protocol    = "udp"
  cidr_blocks = ["${var.resolver_outbound_security_group_egress_allowed_cidrs}"]
}

resource "aws_security_group_rule" "this_outbound_out_853_tcp" {
  count = "${var.enable ? var.resolver_outbound_count : 0}"

  security_group_id = "${element(aws_security_group.this_outbound.*.id, count.index)}"

  type        = "egress"
  from_port   = 853
  to_port     = 853
  protocol    = "tcp"
  cidr_blocks = ["${var.resolver_outbound_security_group_egress_allowed_cidrs}"]
}

resource "aws_security_group_rule" "this_outbound_out_853_udp" {
  count = "${var.enable ? var.resolver_outbound_count : 0}"

  security_group_id = "${element(aws_security_group.this_outbound.*.id, count.index)}"

  type        = "egress"
  from_port   = 853
  to_port     = 853
  protocol    = "udp"
  cidr_blocks = ["${var.resolver_outbound_security_group_egress_allowed_cidrs}"]
}
