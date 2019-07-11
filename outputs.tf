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
# Resolver endpoints
#####

output "resolver_inbound_security_group_id" {
  description = "ID of the security group shared with the INBOUND resolvers."
  value       = "${element(compact(concat(aws_security_group.this_inbound.*.id, list(""))), 0)}"
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
