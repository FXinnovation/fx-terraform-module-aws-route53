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
