output "route53_zone_private_ids" {
  value = "${module.default_alternative.zone_private_ids}"
}

output "route53_zone_public_ids" {
  value = "${module.default_alternative.zone_public_ids}"
}

output "route53_resolver_inbound_security_group_ids" {
  value = "${module.default_alternative.resolver_inbound_security_group_ids}"
}

output "route53_resolver_inbound_ids" {
  value = "${module.default_alternative.resolver_inbound_ids}"
}

output "route53_resolver_inbound_arns" {
  value = "${module.default_alternative.resolver_inbound_arns}"
}

output "route53_resolver_inbound_host_vpc_ids" {
  value = "${module.default_alternative.resolver_inbound_host_vpc_ids}"
}
