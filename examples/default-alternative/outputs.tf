#####
# Hosted zone
#####

output "route53_zone_private_ids" {
  description = "IDs of the private hosted zones."
  value       = module.default_alternative.zone_private_ids
}

output "route53_zone_private_name_servers" {
  description = "A list of name servers in associated (or default) delegation set."
  value       = module.default_alternative.zone_private_name_servers
}

output "route53_zone_public_ids" {
  description = "IDs of the public hosted zones."
  value       = module.default_alternative.zone_public_ids
}

output "route53_zone_public_name_servers" {
  description = "A list of name servers in associated (or default) delegation set."
  value       = module.default_alternative.zone_public_name_servers
}

output "route53_zone_association_private_id" {
  description = "The calculated unique identifier for the association."
  value       = module.default_alternative.zone_association_private_id
}

output "route53_zone_association_private_zone_id" {
  description = "The ID of the hosted zone for the association."
  value       = module.default_alternative.zone_association_private_zone_id
}

output "route53_zone_association_private_vpc_id" {
  description = "The ID of the VPC for the association."
  value       = module.default_alternative.zone_association_private_vpc_id
}

output "route53_zone_association_private_vpc_region" {
  description = "The region in which the VPC identified by vpc_id was created."
  value       = module.default_alternative.zone_association_private_vpc_region
}

#####
# Resolver endpoints inbound
#####

output "route53_resolver_inbound_security_group_ids" {
  description = "IDs of the security group for the INBOUND resolvers."
  value       = module.default_alternative.resolver_inbound_security_group_ids
}

output "route53_resolver_inbound_ids" {
  description = "ID of the security group shared with the INBOUND resolvers."
  value       = module.default_alternative.resolver_inbound_ids
}

output "route53_resolver_inbound_arns" {
  description = "ID of the security group shared with the INBOUND resolvers."
  value       = module.default_alternative.resolver_inbound_arns
}

output "route53_resolver_inbound_host_vpc_ids" {
  description = "IDs of the host VPC of the the INBOUND resolvers."
  value       = module.default_alternative.resolver_inbound_host_vpc_ids
}

#####
# Resolver endpoints outbound
#####

output "route53_resolver_outbound_security_group_id" {
  description = "ID of the security group shared with the OUTBOUND resolvers."
  value       = module.default_alternative.resolver_outbound_security_group_id
}

output "route53_resolver_outbound_ids" {
  description = "ID of the security group shared with the OUTBOUND resolvers."
  value       = module.default_alternative.resolver_outbound_ids
}

output "route53_resolver_outbound_arns" {
  description = "ID of the security group shared with the OUTBOUND resolvers."
  value       = module.default_alternative.resolver_outbound_arns
}

output "route53_resolver_outbound_host_vpc_ids" {
  description = "IDs of the host VPC of the the OUTBOUND resolvers."
  value       = module.default_alternative.resolver_outbound_host_vpc_ids
}

#####
# Forward rules
#####

output "route53_rule_forward_ids" {
  description = "IDs of the resolver rules."
  value       = module.default_alternative.rule_forward_ids
}

output "route53_rule_forward_arns" {
  description = "ARNs of the resolver rules."
  value       = module.default_alternative.rule_forward_arns
}

output "route53_rule_forward_owner_ids" {
  description = "When the rules are shared with other AWS accounts, the account IDs of the accounts that the rules are shared with."
  value       = module.default_alternative.rule_forward_owner_ids
}

output "route53_rule_forward_share_statuses" {
  description = "Whether the rules are shared and, if so, whether the current account is sharing the rules with other accounts, or another account is sharing the rules with the current account. Values are NOT_SHARED, SHARED_BY_ME or SHARED_WITH_ME."
  value       = module.default_alternative.rule_forward_share_statuses
}

output "route53_rule_association_forward_id" {
  description = "The ID of the resolver rule association."
  value       = module.default_alternative.rule_association_forward_id
}

#####
# Resource share
#####

output "route53_rule_forward_share_ids" {
  description = "IDs of the resource shares for the resolver forward rules."
  value       = module.default_alternative.rule_forward_share_ids
}

output "route53_rule_forward_share_arns" {
  description = "ARNs of the resource shares for the resolver forward rules."
  value       = module.default_alternative.rule_forward_share_arns
}

output "route53_resource_association_forward_id" {
  description = "The Amazon Resource Name (ARN) of the resource share."
  value       = module.default_alternative.resource_association_forward_id
}

output "route53_principal_association_forward_id" {
  description = "The Amazon Resource Name (ARN) of the Resource Share and the principal, separated by a comma."
  value       = module.default_alternative.principal_association_forward_id
}

#####
# Records
#####

output "route53_record_names" {
  description = "Names of the records."
  value       = module.default_alternative.record_names
}

output "route53_record_fqdns" {
  description = "FQDNs built using the zone domains and names of the records."
  value       = module.default_alternative.record_fqdns
}

