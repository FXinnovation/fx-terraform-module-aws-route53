output "route53_zone_private_ids" {
  value = "${module.default_alternative.zone_private_ids}"
}

output "route53_zone_public_ids" {
  value = "${module.default_alternative.zone_public_ids}"
}
