#####
# Hosted zone
#####

output "zone_private_ids" {
  description = "IDs of the private hosted zones."
  value       = "${compact(concat(aws_route53_zone.this_private.*.zone_id, list("")))}"
}

output "zone_public_ids" {
  description = "IDs of the public hosted zones."
  value       = "${compact(concat(aws_route53_zone.this_public.*.zone_id, list("")))}"
}

#####
# Resolver endpoints inbound
#####

output "resolver_inbound_security_group_ids" {
  description = "IDs of the security group for the INBOUND resolvers."
  value       = "${compact(concat(aws_security_group.this_inbound.*.id, list("")))}"
}

output "resolver_inbound_ids" {
  description = "ID of the security group shared with the INBOUND resolvers."
  value       = "${compact(concat(aws_route53_resolver_endpoint.this_inbound.*.id, list("")))}"
}

output "resolver_inbound_arns" {
  description = "ID of the security group shared with the INBOUND resolvers."
  value       = "${compact(concat(aws_route53_resolver_endpoint.this_inbound.*.arn, list("")))}"
}

output "resolver_inbound_host_vpc_ids" {
  description = "IDs of the host VPC of the the INBOUND resolvers."
  value       = "${compact(concat(aws_route53_resolver_endpoint.this_inbound.*.host_vpc_id, list("")))}"
}

#####
# Resolver endpoints outbound
#####

output "resolver_outbound_security_group_id" {
  description = "ID of the security group shared with the OUTBOUND resolvers."
  value       = "${element(concat(aws_security_group.this_outbound.*.id, list("")), 0)}"
}

output "resolver_outbound_ids" {
  description = "ID of the security group shared with the OUTBOUND resolvers."
  value       = "${compact(concat(aws_route53_resolver_endpoint.this_outbound.*.id, list("")))}"
}

output "resolver_outbound_arns" {
  description = "ID of the security group shared with the OUTBOUND resolvers."
  value       = "${compact(concat(aws_route53_resolver_endpoint.this_outbound.*.arn, list("")))}"
}

output "resolver_outbound_host_vpc_ids" {
  description = "IDs of the host VPC of the the OUTBOUND resolvers."
  value       = "${compact(concat(aws_route53_resolver_endpoint.this_outbound.*.host_vpc_id, list("")))}"
}

#####
# Forward rules
#####

output "rule_forward_ids" {
  description = "IDs of the resolver rules."
  value       = "${compact(concat(aws_route53_resolver_rule.this_forward.*.id, list("")))}"
}

output "rule_forward_arns" {
  description = "ARNs of the resolver rules."
  value       = "${compact(concat(aws_route53_resolver_rule.this_forward.*.arn, list("")))}"
}

output "rule_forward_owner_ids" {
  description = "When the rules are shared with other AWS accounts, the account IDs of the accounts that the rules are shared with."
  value       = "${compact(concat(aws_route53_resolver_rule.this_forward.*.owner_id, list("")))}"
}

output "rule_forward_share_statuses" {
  description = "Whether the rules are shared and, if so, whether the current account is sharing the rules with other accounts, or another account is sharing the rules with the current account. Values are NOT_SHARED, SHARED_BY_ME or SHARED_WITH_ME."
  value       = "${compact(concat(aws_route53_resolver_rule.this_forward.*.share_status, list("")))}"
}
