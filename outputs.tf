#####
# Hosted zone
#####

output "zone_private_ids" {
  description = "IDs of the private hosted zones."
  value       = compact(concat(aws_route53_zone.this_private.*.zone_id, [""]))
}

output "zone_private_name_servers" {
  description = "A list of name servers in associated (or default) delegation set."

  #value       = "${compact(concat(aws_route53_zone.this_private.*.name_servers, list("")))}"
  value = flatten(aws_route53_zone.this_private.*.name_servers)
}

output "zone_public_ids" {
  description = "IDs of the public hosted zones."
  value       = compact(concat(aws_route53_zone.this_public.*.zone_id, [""]))
}

output "zone_public_name_servers" {
  description = "A list of name servers in associated (or default) delegation set."

  #value       = "${compact(concat(aws_route53_zone.this_public.*.name_servers, list("")))}"
  value = flatten(aws_route53_zone.this_public.*.name_servers)
}

output "zone_association_private_id" {
  description = "The calculated unique identifier for the association."
  value       = compact(concat(aws_route53_zone_association.this_private.*.id, [""]))
}

output "zone_association_private_zone_id" {
  description = "The ID of the hosted zone for the association."
  value = compact(
    concat(aws_route53_zone_association.this_private.*.zone_id, [""]),
  )
}

output "zone_association_private_vpc_id" {
  description = "The ID of the VPC for the association."
  value = compact(
    concat(aws_route53_zone_association.this_private.*.vpc_id, [""]),
  )
}

output "zone_association_private_vpc_region" {
  description = "The region in which the VPC identified by vpc_id was created."
  value = compact(
    concat(aws_route53_zone_association.this_private.*.vpc_region, [""]),
  )
}

#####
# Resolver endpoints inbound
#####

output "resolver_inbound_security_group_ids" {
  description = "IDs of the security group for the INBOUND resolvers."
  value       = compact(concat(aws_security_group.this_inbound.*.id, [""]))
}

output "resolver_inbound_ids" {
  description = "ID of the security group shared with the INBOUND resolvers."
  value = compact(
    concat(aws_route53_resolver_endpoint.this_inbound.*.id, [""]),
  )
}

output "resolver_inbound_arns" {
  description = "ID of the security group shared with the INBOUND resolvers."
  value = compact(
    concat(aws_route53_resolver_endpoint.this_inbound.*.arn, [""]),
  )
}

output "resolver_inbound_host_vpc_ids" {
  description = "IDs of the host VPC of the the INBOUND resolvers."
  value = compact(
    concat(
      aws_route53_resolver_endpoint.this_inbound.*.host_vpc_id,
      [""],
    ),
  )
}

#####
# Resolver endpoints outbound
#####

output "resolver_outbound_security_group_id" {
  description = "ID of the security group shared with the OUTBOUND resolvers."
  value       = element(concat(aws_security_group.this_outbound.*.id, [""]), 0)
}

output "resolver_outbound_ids" {
  description = "ID of the security group shared with the OUTBOUND resolvers."
  value = compact(
    concat(aws_route53_resolver_endpoint.this_outbound.*.id, [""]),
  )
}

output "resolver_outbound_arns" {
  description = "ID of the security group shared with the OUTBOUND resolvers."
  value = compact(
    concat(aws_route53_resolver_endpoint.this_outbound.*.arn, [""]),
  )
}

output "resolver_outbound_host_vpc_ids" {
  description = "IDs of the host VPC of the the OUTBOUND resolvers."
  value = compact(
    concat(
      aws_route53_resolver_endpoint.this_outbound.*.host_vpc_id,
      [""],
    ),
  )
}

#####
# Forward rules
#####

output "rule_forward_ids" {
  description = "IDs of the resolver rules."
  value       = compact(concat(aws_route53_resolver_rule.this_forward.*.id, [""]))
}

output "rule_forward_arns" {
  description = "ARNs of the resolver rules."
  value       = compact(concat(aws_route53_resolver_rule.this_forward.*.arn, [""]))
}

output "rule_forward_owner_ids" {
  description = "When the rules are shared with other AWS accounts, the account IDs of the accounts that the rules are shared with."
  value = compact(
    concat(aws_route53_resolver_rule.this_forward.*.owner_id, [""]),
  )
}

output "rule_forward_share_statuses" {
  description = "Whether the rules are shared and, if so, whether the current account is sharing the rules with other accounts, or another account is sharing the rules with the current account. Values are NOT_SHARED, SHARED_BY_ME or SHARED_WITH_ME."
  value = compact(
    concat(aws_route53_resolver_rule.this_forward.*.share_status, [""]),
  )
}

output "rule_association_forward_id" {
  description = "The ID of the resolver rule association."
  value = compact(
    concat(
      aws_route53_resolver_rule_association.this_forward.*.id,
      [""],
    ),
  )
}

#####
# Resource share
#####

output "rule_forward_share_ids" {
  description = "IDs of the resource shares for the resolver forward rules."
  value       = compact(concat(aws_ram_resource_share.this_forward.*.id, [""]))
}

output "rule_forward_share_arns" {
  description = "ARNs of the resource shares for the resolver forward rules."
  value       = compact(concat(aws_ram_resource_share.this_forward.*.arn, [""]))
}

output "resource_association_forward_id" {
  description = "The Amazon Resource Name (ARN) of the resource share."
  value       = compact(concat(aws_ram_resource_association.this_forward.*.id, [""]))
}

output "principal_association_forward_id" {
  description = "The Amazon Resource Name (ARN) of the Resource Share and the principal, separated by a comma."
  value = compact(
    concat(aws_ram_principal_association.this_forward.*.id, [""]),
  )
}

#####
# Records
#####

output "record_names" {
  description = "Names of the records."
  value = compact(
    concat(
      aws_route53_record.this.*.name,
      aws_route53_record.this_alias.*.name,
    ),
  )
}

output "record_fqdns" {
  description = "FQDNs built using the zone domains and names of the records."
  value = compact(
    concat(
      aws_route53_record.this.*.fqdn,
      aws_route53_record.this_alias.*.fqdn,
    ),
  )
}
