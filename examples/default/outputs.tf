output "route53_zone_private_ids" {
  value = "${module.default.zone_private_ids}"
}

output "route53_zone_public_ids" {
  value = "${module.default.zone_public_ids}"
}
