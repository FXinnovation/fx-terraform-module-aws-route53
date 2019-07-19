output "route53_zone_private_ids" {
  value = "${module.disable.zone_private_ids}"
}

output "route53_zone_public_ids" {
  value = "${module.disable.zone_public_ids}"
}

output "route53_resolver_inbound_security_group_ids" {
  value = "${module.disable.resolver_inbound_security_group_ids}"
}

output "route53_resolver_inbound_ids" {
  value = "${module.disable.resolver_inbound_ids}"
}

output "route53_resolver_inbound_arns" {
  value = "${module.disable.resolver_inbound_arns}"
}

output "route53_resolver_inbound_host_vpc_ids" {
  value = "${module.disable.resolver_inbound_host_vpc_ids}"
}

output "route53_resolver_outbound_security_group_id" {
  value = "${module.disable.resolver_outbound_security_group_id}"
}

output "route53_resolver_outbound_ids" {
  value = "${module.disable.resolver_outbound_ids}"
}

output "route53_resolver_outbound_arns" {
  value = "${module.disable.resolver_outbound_arns}"
}

output "route53_resolver_outbound_host_vpc_ids" {
  value = "${module.disable.resolver_outbound_host_vpc_ids}"
}

output "route53_rule_forward_ids" {
  value = "${module.disable.rule_forward_ids}"
}

output "route53_rule_forward_arns" {
  value = "${module.disable.rule_forward_arns}"
}

output "route53_rule_forward_owner_ids" {
  value = "${module.disable.rule_forward_owner_ids}"
}

output "route53_rule_forward_share_statuses" {
  value = "${module.disable.rule_forward_share_statuses}"
}

output "route53_rule_forward_share_ids" {
  value = "${module.disable.rule_forward_share_ids}"
}

output "route53_rule_forward_share_arns" {
  value = "${module.disable.rule_forward_share_arns}"
}

output "record_names" {
  value = "${module.disable.record_names}"
}

output "record_fqdns" {
  value = "${module.disable.record_fqdns}"
}
