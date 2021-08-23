# Terraform Route53 module

This module is not to be deployed directly.

Limitations:
- All resolvers of the same type shares the same security group rules.
- All resolvers must have an exact number of 2 IPs. This cannot be worked around in Terraform 0.11.
- There is no way to auto accept resource shares with the aws provider 2.18.
That’s why the resource shares created with this module must be accepted manually on receiving accounts.
- AWS does not offer a way to auto-accept zones associations between account.
In the case zones must be shared between VPCs of different account, this should be done manually until this is solved: https://github.com/terraform-providers/terraform-provider-aws/issues/617.
See this https://docs.aws.amazon.com/cli/latest/reference/route53/create-vpc-association-authorization.html for manual handling.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ram_principal_association.this_forward](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_principal_association) | resource |
| [aws_ram_resource_association.this_forward](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_resource_association) | resource |
| [aws_ram_resource_share.this_forward](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_resource_share) | resource |
| [aws_route53_record.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_record.this_alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_route53_resolver_endpoint.this_inbound](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_endpoint) | resource |
| [aws_route53_resolver_endpoint.this_outbound](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_endpoint) | resource |
| [aws_route53_resolver_rule.this_forward](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_rule) | resource |
| [aws_route53_resolver_rule_association.this_forward](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_rule_association) | resource |
| [aws_route53_zone.this_private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone) | resource |
| [aws_route53_zone.this_public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone) | resource |
| [aws_route53_zone_association.this_private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone_association) | resource |
| [aws_security_group.this_inbound](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.this_outbound](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.this_inbound_53_tcp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.this_inbound_53_udp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.this_inbound_853_tcp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.this_inbound_853_udp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.this_inbound_out_53_tcp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.this_inbound_out_53_udp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.this_inbound_out_853_tcp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.this_inbound_out_853_udp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.this_outbound_53_tcp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.this_outbound_53_udp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.this_outbound_853_tcp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.this_outbound_853_udp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.this_outbound_out_53_tcp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.this_outbound_out_53_udp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.this_outbound_out_853_tcp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.this_outbound_out_853_udp](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_route53_zone.this_private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |
| [aws_subnet.this_inbound](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_subnet.this_outbound](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enable"></a> [enable](#input\_enable) | Whether or not to enable this entire module or not. | `bool` | `true` | no |
| <a name="input_record_alias_dns_names"></a> [record\_alias\_dns\_names](#input\_record\_alias\_dns\_names) | DNS domain names for a CloudFront distribution, S3 bucket, ELB, or another resource record for the alias records to create. See var.record\_alias\_zone\_indexes as it is requited to bind records with specific zones. | `list` | `[]` | no |
| <a name="input_record_alias_domain_names"></a> [record\_alias\_domain\_names](#input\_record\_alias\_domain\_names) | Domain names of the alias records to create. See var.record\_alias\_zone\_indexes as it is requited to bind records with specific zones. | `list` | `[]` | no |
| <a name="input_record_alias_evaluate_healths"></a> [record\_alias\_evaluate\_healths](#input\_record\_alias\_evaluate\_healths) | Whether or not to evaluate the health of each alias records to create. See var.record\_alias\_zone\_indexes as it is requited to bind records with specific zones. | `list` | `[]` | no |
| <a name="input_record_alias_types"></a> [record\_alias\_types](#input\_record\_alias\_types) | Types (valid values are A, AAAA, CAA, CNAME, MX, NAPTR, NS, PTR, SOA, SPF, SRV and TXT) of the alias records to create. See var.record\_alias\_zone\_indexes as it is requited to bind records with specific zones. | `list` | `[]` | no |
| <a name="input_record_alias_zone_id"></a> [record\_alias\_zone\_id](#input\_record\_alias\_zone\_id) | Hosted zone ID for a CloudFront distribution, S3 bucket, ELB, or Route 53 hosted zones for the alias records to create. See var.record\_alias\_zone\_indexes as it is requited to bind records with specific zones. | `list` | `[]` | no |
| <a name="input_record_alias_zone_indexes"></a> [record\_alias\_zone\_indexes](#input\_record\_alias\_zone\_indexes) | Indexes of the zone ids (merge of the private & public zones created by this module - in this order) to bind with specific alias records. Must have the same number of element than: var.record\_alias\_domain\_names, var.record\_alias\_types, etc. | `list` | `[]` | no |
| <a name="input_record_domain_names"></a> [record\_domain\_names](#input\_record\_domain\_names) | Domain names of the records to create. See var.record\_zone\_indexes as it is requited to bind records with specific zones. | `list` | `[]` | no |
| <a name="input_record_records"></a> [record\_records](#input\_record\_records) | Object of string lists of recordsDomain names for the records to create. See var.record\_zone\_indexes as it is requited to bind records with specific zones. See example for proper usage. | `map` | `{}` | no |
| <a name="input_record_ttls"></a> [record\_ttls](#input\_record\_ttls) | Domain names of the records to create. See var.record\_zone\_indexes as it is requited to bind records with specific zones. | `list` | `[]` | no |
| <a name="input_record_types"></a> [record\_types](#input\_record\_types) | Types (valid values are A, AAAA, CAA, CNAME, MX, NAPTR, NS, PTR, SOA, SPF, SRV and TXT) of the records to create. See var.record\_zone\_indexes as it is requited to bind records with specific zones. | `list` | `[]` | no |
| <a name="input_record_zone_indexes"></a> [record\_zone\_indexes](#input\_record\_zone\_indexes) | Indexes of the zone ids (merge of the private & public zones created by this module - in this order) to bind with specific records. Must have the same number of element than: var.record\_domain\_names, var.record\_types, etc. | `list` | `[]` | no |
| <a name="input_resolver_inbound_count"></a> [resolver\_inbound\_count](#input\_resolver\_inbound\_count) | How many INBOUND resolvers to be created in the module. This value cannot be computed automatically in Terraform 0.11. | `number` | `0` | no |
| <a name="input_resolver_inbound_ip_addresses"></a> [resolver\_inbound\_ip\_addresses](#input\_resolver\_inbound\_ip\_addresses) | Object of lists containing the IP addresses corresponding to the subnet IDs for the INBOUND resolvers to be created in the module. Look at examples for correct usage. | `map` | `{}` | no |
| <a name="input_resolver_inbound_names"></a> [resolver\_inbound\_names](#input\_resolver\_inbound\_names) | Names of the INBOUND resolvers to be created in the module. | `list` | `[]` | no |
| <a name="input_resolver_inbound_security_group_egress_allowed_cidrs"></a> [resolver\_inbound\_security\_group\_egress\_allowed\_cidrs](#input\_resolver\_inbound\_security\_group\_egress\_allowed\_cidrs) | CIDRs allowed to perform DNS request to the INBOUND resolvers, egress rules. | `list` | <pre>[<br>  "10.0.0.0/8"<br>]</pre> | no |
| <a name="input_resolver_inbound_security_group_ingress_allowed_cidrs"></a> [resolver\_inbound\_security\_group\_ingress\_allowed\_cidrs](#input\_resolver\_inbound\_security\_group\_ingress\_allowed\_cidrs) | CIDRs allowed to perform DNS request to the INBOUND resolvers, ingress rules. | `list` | <pre>[<br>  "10.0.0.0/8"<br>]</pre> | no |
| <a name="input_resolver_inbound_security_group_name"></a> [resolver\_inbound\_security\_group\_name](#input\_resolver\_inbound\_security\_group\_name) | Name of the security groups shared for INBOUND resolvers. | `string` | `"inbound-resolver"` | no |
| <a name="input_resolver_inbound_subnet_ids"></a> [resolver\_inbound\_subnet\_ids](#input\_resolver\_inbound\_subnet\_ids) | Object of lists containing the subnet IDs corresponding to the IP addresses for the INBOUND resolvers to be created in the module. Look at examples for correct usage. | `map` | `{}` | no |
| <a name="input_resolver_outbound_count"></a> [resolver\_outbound\_count](#input\_resolver\_outbound\_count) | How many OUTBOUND resolvers to be created in the module. This value cannot be computed automatically in Terraform 0.11. | `number` | `0` | no |
| <a name="input_resolver_outbound_ip_addresses"></a> [resolver\_outbound\_ip\_addresses](#input\_resolver\_outbound\_ip\_addresses) | Object of lists containing the IP addresses corresponding to the subnet IDs for the OUTBOUND resolvers to be created in the module. Look at examples for correct usage. | `map` | `{}` | no |
| <a name="input_resolver_outbound_names"></a> [resolver\_outbound\_names](#input\_resolver\_outbound\_names) | Names of the OUTBOUND resolvers to be created in the module. | `list` | `[]` | no |
| <a name="input_resolver_outbound_security_group_egress_allowed_cidrs"></a> [resolver\_outbound\_security\_group\_egress\_allowed\_cidrs](#input\_resolver\_outbound\_security\_group\_egress\_allowed\_cidrs) | CIDRs allowed to perform DNS request to the OUTBOUND resolvers, egress rules. | `list` | <pre>[<br>  "10.0.0.0/8"<br>]</pre> | no |
| <a name="input_resolver_outbound_security_group_ingress_allowed_cidrs"></a> [resolver\_outbound\_security\_group\_ingress\_allowed\_cidrs](#input\_resolver\_outbound\_security\_group\_ingress\_allowed\_cidrs) | CIDRs allowed to perform DNS request to the OUTBOUND resolvers, ingress rules. | `list` | <pre>[<br>  "10.0.0.0/8"<br>]</pre> | no |
| <a name="input_resolver_outbound_security_group_name"></a> [resolver\_outbound\_security\_group\_name](#input\_resolver\_outbound\_security\_group\_name) | Name of the security groups shared for OUTBOUND resolvers. | `string` | `"outbound-resolver"` | no |
| <a name="input_resolver_outbound_subnet_ids"></a> [resolver\_outbound\_subnet\_ids](#input\_resolver\_outbound\_subnet\_ids) | Object of lists containing the subnet IDs corresponding to the IP addresses for the OUTBOUND resolvers to be created in the module. Look at examples for correct usage. | `map` | `{}` | no |
| <a name="input_resolver_tags"></a> [resolver\_tags](#input\_resolver\_tags) | Tags specific to the resolvers to be created in the module. Will be merged with tags. | `map` | `{}` | no |
| <a name="input_rule_forward_attachement_ids"></a> [rule\_forward\_attachement\_ids](#input\_rule\_forward\_attachement\_ids) | IDs of the forward resolver rules that should be attached to the rule\_forward\_vpc\_attachement\_ids. If not specify, the forward rules created by this module will be used for all the attachments. | `list` | `[]` | no |
| <a name="input_rule_forward_attachement_ids_count"></a> [rule\_forward\_attachement\_ids\_count](#input\_rule\_forward\_attachement\_ids\_count) | How many var.rule\_forward\_attachement\_ids. This value cannot be computed automatically in Terraform 0.11. | `number` | `0` | no |
| <a name="input_rule_forward_count"></a> [rule\_forward\_count](#input\_rule\_forward\_count) | How many resolvers forward rules to be created in the module. This value cannot be computed automatically in Terraform 0.11. | `number` | `0` | no |
| <a name="input_rule_forward_domain_names"></a> [rule\_forward\_domain\_names](#input\_rule\_forward\_domain\_names) | Domain names of the resolvers forward rules to be created in the module. DNS queries for these domain names are forwarded to the IP addresses that are specified using target\_ip. | `list` | `[]` | no |
| <a name="input_rule_forward_names"></a> [rule\_forward\_names](#input\_rule\_forward\_names) | Names of the resolvers forward rules to be created in the module. Friendly names that lets you easily find a rule in the Resolver dashboard in the Route 53 console. | `list` | `[]` | no |
| <a name="input_rule_forward_resolver_endpoint_ids"></a> [rule\_forward\_resolver\_endpoint\_ids](#input\_rule\_forward\_resolver\_endpoint\_ids) | IDs of the resolver endpoints to be used for the resolver forward rules. If not specify, the first OUBOUND resolver created by this module will be used for all the rules. | `list` | `[]` | no |
| <a name="input_rule_forward_resolver_target_ips"></a> [rule\_forward\_resolver\_target\_ips](#input\_rule\_forward\_resolver\_target\_ips) | Object of lists of objects containing target IPs for the resolver forward rules. IPs that you want resolvers to forward DNS queries to. Look at examples for correct usage. | `map` | `{}` | no |
| <a name="input_rule_forward_share_indexes"></a> [rule\_forward\_share\_indexes](#input\_rule\_forward\_share\_indexes) | Indexes of the forward rules to be shared with other principals (rule\_forward\_share\_principals). See examples for correct usage. | `list` | `[]` | no |
| <a name="input_rule_forward_share_names"></a> [rule\_forward\_share\_names](#input\_rule\_forward\_share\_names) | Names of the resource shares resolvers for forward rules to be created in the module. | `list` | `[]` | no |
| <a name="input_rule_forward_share_principal_count"></a> [rule\_forward\_share\_principal\_count](#input\_rule\_forward\_share\_principal\_count) | How many accounts must receive the resource shares for forward rules to be created in the module. This value cannot be computed automatically in Terraform 0.11. | `number` | `0` | no |
| <a name="input_rule_forward_share_principals"></a> [rule\_forward\_share\_principals](#input\_rule\_forward\_share\_principals) | IDs of the accounts that must receive the resource shares for forward rules to be created in the module. | `list` | `[]` | no |
| <a name="input_rule_forward_share_tags"></a> [rule\_forward\_share\_tags](#input\_rule\_forward\_share\_tags) | Tags specific to the resource shares for the forward rules to be created in the module. Will be merged with tags. | `map` | `{}` | no |
| <a name="input_rule_forward_tags"></a> [rule\_forward\_tags](#input\_rule\_forward\_tags) | Tags specific to the resolvers forward rules to be created in the module. Will be merged with tags. | `map` | `{}` | no |
| <a name="input_rule_forward_vpc_attachement_count"></a> [rule\_forward\_vpc\_attachement\_count](#input\_rule\_forward\_vpc\_attachement\_count) | How many resolver forward rule attachments should be created in the module. This value cannot be computed automatically in Terraform 0.11. | `number` | `0` | no |
| <a name="input_rule_forward_vpc_attachement_ids"></a> [rule\_forward\_vpc\_attachement\_ids](#input\_rule\_forward\_vpc\_attachement\_ids) | IDs of the VPC to be attached to the resolver forward rules of this module. | `list` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be shared among all resources of this module. | `map` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of the VPC where to create resources for this module. | `string` | `""` | no |
| <a name="input_zone_private_comments"></a> [zone\_private\_comments](#input\_zone\_private\_comments) | Comments of private hosted zones to be created in the module. | `list` | `[]` | no |
| <a name="input_zone_private_count"></a> [zone\_private\_count](#input\_zone\_private\_count) | How many private hosted zones should be created in the module. This value cannot be computed automatically in Terraform 0.11. | `number` | `0` | no |
| <a name="input_zone_private_ids"></a> [zone\_private\_ids](#input\_zone\_private\_ids) | IDs of existing private hosted zones to be used. If not specified, the module will create a new hosted zones according to other variables. | `list` | `[]` | no |
| <a name="input_zone_private_ids_count"></a> [zone\_private\_ids\_count](#input\_zone\_private\_ids\_count) | How many existing private IDs of private hosted zones are passed. This value cannot be computed automatically in Terraform 0.11. | `number` | `0` | no |
| <a name="input_zone_private_names"></a> [zone\_private\_names](#input\_zone\_private\_names) | Names of private hosted zones to be created in the module. | `list` | `[]` | no |
| <a name="input_zone_private_vpc_attachement_count"></a> [zone\_private\_vpc\_attachement\_count](#input\_zone\_private\_vpc\_attachement\_count) | How many private hosted zones attachments should be created in the module. This should not contain the current VPC. This value cannot be computed automatically in Terraform 0.11. | `number` | `0` | no |
| <a name="input_zone_private_vpc_attachement_ids"></a> [zone\_private\_vpc\_attachement\_ids](#input\_zone\_private\_vpc\_attachement\_ids) | IDs of the VPC to be attached to the private hosted zones of this module. This should not contain the current VPC as it will be attached automatically. | `list` | `[]` | no |
| <a name="input_zone_public_comments"></a> [zone\_public\_comments](#input\_zone\_public\_comments) | Comments of public hosted zones to be created in the module. | `list` | `[]` | no |
| <a name="input_zone_public_count"></a> [zone\_public\_count](#input\_zone\_public\_count) | How many public hosted zones should be created in the module. This value cannot be computed automatically in Terraform 0.11. | `number` | `0` | no |
| <a name="input_zone_public_names"></a> [zone\_public\_names](#input\_zone\_public\_names) | Names of public hosted zones to be created in the module. | `list` | `[]` | no |
| <a name="input_zone_tags"></a> [zone\_tags](#input\_zone\_tags) | Tags specific to the hosted zones to be created in the module. Will be merged with tags. | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_principal_association_forward_id"></a> [principal\_association\_forward\_id](#output\_principal\_association\_forward\_id) | The Amazon Resource Name (ARN) of the Resource Share and the principal, separated by a comma. |
| <a name="output_record_fqdns"></a> [record\_fqdns](#output\_record\_fqdns) | FQDNs built using the zone domains and names of the records. |
| <a name="output_record_names"></a> [record\_names](#output\_record\_names) | Names of the records. |
| <a name="output_resolver_inbound_arns"></a> [resolver\_inbound\_arns](#output\_resolver\_inbound\_arns) | ID of the security group shared with the INBOUND resolvers. |
| <a name="output_resolver_inbound_host_vpc_ids"></a> [resolver\_inbound\_host\_vpc\_ids](#output\_resolver\_inbound\_host\_vpc\_ids) | IDs of the host VPC of the the INBOUND resolvers. |
| <a name="output_resolver_inbound_ids"></a> [resolver\_inbound\_ids](#output\_resolver\_inbound\_ids) | ID of the security group shared with the INBOUND resolvers. |
| <a name="output_resolver_inbound_security_group_ids"></a> [resolver\_inbound\_security\_group\_ids](#output\_resolver\_inbound\_security\_group\_ids) | IDs of the security group for the INBOUND resolvers. |
| <a name="output_resolver_outbound_arns"></a> [resolver\_outbound\_arns](#output\_resolver\_outbound\_arns) | ID of the security group shared with the OUTBOUND resolvers. |
| <a name="output_resolver_outbound_host_vpc_ids"></a> [resolver\_outbound\_host\_vpc\_ids](#output\_resolver\_outbound\_host\_vpc\_ids) | IDs of the host VPC of the the OUTBOUND resolvers. |
| <a name="output_resolver_outbound_ids"></a> [resolver\_outbound\_ids](#output\_resolver\_outbound\_ids) | ID of the security group shared with the OUTBOUND resolvers. |
| <a name="output_resolver_outbound_security_group_id"></a> [resolver\_outbound\_security\_group\_id](#output\_resolver\_outbound\_security\_group\_id) | ID of the security group shared with the OUTBOUND resolvers. |
| <a name="output_resource_association_forward_id"></a> [resource\_association\_forward\_id](#output\_resource\_association\_forward\_id) | The Amazon Resource Name (ARN) of the resource share. |
| <a name="output_rule_association_forward_id"></a> [rule\_association\_forward\_id](#output\_rule\_association\_forward\_id) | The ID of the resolver rule association. |
| <a name="output_rule_forward_arns"></a> [rule\_forward\_arns](#output\_rule\_forward\_arns) | ARNs of the resolver rules. |
| <a name="output_rule_forward_ids"></a> [rule\_forward\_ids](#output\_rule\_forward\_ids) | IDs of the resolver rules. |
| <a name="output_rule_forward_owner_ids"></a> [rule\_forward\_owner\_ids](#output\_rule\_forward\_owner\_ids) | When the rules are shared with other AWS accounts, the account IDs of the accounts that the rules are shared with. |
| <a name="output_rule_forward_share_arns"></a> [rule\_forward\_share\_arns](#output\_rule\_forward\_share\_arns) | ARNs of the resource shares for the resolver forward rules. |
| <a name="output_rule_forward_share_ids"></a> [rule\_forward\_share\_ids](#output\_rule\_forward\_share\_ids) | IDs of the resource shares for the resolver forward rules. |
| <a name="output_rule_forward_share_statuses"></a> [rule\_forward\_share\_statuses](#output\_rule\_forward\_share\_statuses) | Whether the rules are shared and, if so, whether the current account is sharing the rules with other accounts, or another account is sharing the rules with the current account. Values are NOT\_SHARED, SHARED\_BY\_ME or SHARED\_WITH\_ME. |
| <a name="output_zone_association_private_id"></a> [zone\_association\_private\_id](#output\_zone\_association\_private\_id) | The calculated unique identifier for the association. |
| <a name="output_zone_association_private_vpc_id"></a> [zone\_association\_private\_vpc\_id](#output\_zone\_association\_private\_vpc\_id) | The ID of the VPC for the association. |
| <a name="output_zone_association_private_vpc_region"></a> [zone\_association\_private\_vpc\_region](#output\_zone\_association\_private\_vpc\_region) | The region in which the VPC identified by vpc\_id was created. |
| <a name="output_zone_association_private_zone_id"></a> [zone\_association\_private\_zone\_id](#output\_zone\_association\_private\_zone\_id) | The ID of the hosted zone for the association. |
| <a name="output_zone_private_ids"></a> [zone\_private\_ids](#output\_zone\_private\_ids) | IDs of the private hosted zones. |
| <a name="output_zone_private_name_servers"></a> [zone\_private\_name\_servers](#output\_zone\_private\_name\_servers) | A list of name servers in associated (or default) delegation set. |
| <a name="output_zone_public_ids"></a> [zone\_public\_ids](#output\_zone\_public\_ids) | IDs of the public hosted zones. |
| <a name="output_zone_public_name_servers"></a> [zone\_public\_name\_servers](#output\_zone\_public\_name\_servers) | A list of name servers in associated (or default) delegation set. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
