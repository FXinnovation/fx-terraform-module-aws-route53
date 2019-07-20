data "aws_route53_zone" "this_private" {
  count = "${var.enable ? var.zone_private_count : 0}"

  zone_id = "${element(concat(var.zone_private_ids, list("")), 0) == "" ? element(concat(aws_route53_zone.this_private.*.id, list("")), 0) : element(concat(var.zone_private_ids, list("")), count.index)}"
}
