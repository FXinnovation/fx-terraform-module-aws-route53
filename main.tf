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
# Records
#####

locals {
  zone_ids   = "${compact(concat(aws_route53_zone.this_private.*.zone_id, aws_route53_zone.this_public.*.zone_id))}"
  zone_names = "${compact(concat(aws_route53_zone.this_private.*.name, aws_route53_zone.this_public.*.name))}"
}
