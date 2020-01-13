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
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| enable | Whether or not to enable this entire module or not. | string | `"true"` | no |
| record\_alias\_dns\_names | DNS domain names for a CloudFront distribution, S3 bucket, ELB, or another resource record for the alias records to create. See var.record_alias_zone_indexes as it is requited to bind records with specific zones. | list | `[]` | no |
| record\_alias\_domain\_names | Domain names of the alias records to create. See var.record_alias_zone_indexes as it is requited to bind records with specific zones. | list | `[]` | no |
| record\_alias\_evaluate\_healths | Whether or not to evaluate the health of each alias records to create. See var.record_alias_zone_indexes as it is requited to bind records with specific zones. | list | `[]` | no |
| record\_alias\_types | Types (valid values are A, AAAA, CAA, CNAME, MX, NAPTR, NS, PTR, SOA, SPF, SRV and TXT) of the alias records to create. See var.record_alias_zone_indexes as it is requited to bind records with specific zones. | list | `[]` | no |
| record\_alias\_zone\_id | Hosted zone ID for a CloudFront distribution, S3 bucket, ELB, or Route 53 hosted zones for the alias records to create. See var.record_alias_zone_indexes as it is requited to bind records with specific zones. | list | `[]` | no |
| record\_alias\_zone\_indexes | Indexes of the zone ids (merge of the private & public zones created by this module - in this order) to bind with specific alias records. Must have the same number of element than: var.record_alias_domain_names, var.record_alias_types, etc. | list | `[]` | no |
| record\_domain\_names | Domain names of the records to create. See var.record_zone_indexes as it is requited to bind records with specific zones. | list | `[]` | no |
| record\_records | Object of string lists of recordsDomain names for the records to create. See var.record_zone_indexes as it is requited to bind records with specific zones. See example for proper usage. | map | `{}` | no |
| record\_ttls | Domain names of the records to create. See var.record_zone_indexes as it is requited to bind records with specific zones. | list | `[]` | no |
| record\_types | Types (valid values are A, AAAA, CAA, CNAME, MX, NAPTR, NS, PTR, SOA, SPF, SRV and TXT) of the records to create. See var.record_zone_indexes as it is requited to bind records with specific zones. | list | `[]` | no |
| record\_zone\_indexes | Indexes of the zone ids (merge of the private & public zones created by this module - in this order) to bind with specific records. Must have the same number of element than: var.record_domain_names, var.record_types, etc. | list | `[]` | no |
| resolver\_inbound\_count | How many INBOUND resolvers to be created in the module. This value cannot be computed automatically in Terraform 0.11. | string | `"0"` | no |
| resolver\_inbound\_ip\_addresses | Object of lists containing the IP addresses corresponding to the subnet IDs for the INBOUND resolvers to be created in the module. Look at examples for correct usage. | map | `{}` | no |
| resolver\_inbound\_names | Names of the INBOUND resolvers to be created in the module. | list | `[]` | no |
| resolver\_inbound\_security\_group\_egress\_allowed\_cidrs | CIDRs allowed to perform DNS request to the INBOUND resolvers, egress rules. | list | `[ "10.0.0.0/8" ]` | no |
| resolver\_inbound\_security\_group\_ingress\_allowed\_cidrs | CIDRs allowed to perform DNS request to the INBOUND resolvers, ingress rules. | list | `[ "10.0.0.0/8" ]` | no |
| resolver\_inbound\_security\_group\_name | Name of the security groups shared for INBOUND resolvers. | string | `"inbound-resolver"` | no |
| resolver\_inbound\_subnet\_ids | Object of lists containing the subnet IDs corresponding to the IP addresses for the INBOUND resolvers to be created in the module. Look at examples for correct usage. | map | `{}` | no |
| resolver\_outbound\_count | How many OUTBOUND resolvers to be created in the module. This value cannot be computed automatically in Terraform 0.11. | string | `"0"` | no |
| resolver\_outbound\_ip\_addresses | Object of lists containing the IP addresses corresponding to the subnet IDs for the OUTBOUND resolvers to be created in the module. Look at examples for correct usage. | map | `{}` | no |
| resolver\_outbound\_names | Names of the OUTBOUND resolvers to be created in the module. | list | `[]` | no |
| resolver\_outbound\_security\_group\_egress\_allowed\_cidrs | CIDRs allowed to perform DNS request to the OUTBOUND resolvers, egress rules. | list | `[ "10.0.0.0/8" ]` | no |
| resolver\_outbound\_security\_group\_ingress\_allowed\_cidrs | CIDRs allowed to perform DNS request to the OUTBOUND resolvers, ingress rules. | list | `[ "10.0.0.0/8" ]` | no |
| resolver\_outbound\_security\_group\_name | Name of the security groups shared for OUTBOUND resolvers. | string | `"outbound-resolver"` | no |
| resolver\_outbound\_subnet\_ids | Object of lists containing the subnet IDs corresponding to the IP addresses for the OUTBOUND resolvers to be created in the module. Look at examples for correct usage. | map | `{}` | no |
| resolver\_tags | Tags specific to the resolvers to be created in the module. Will be merged with tags. | map | `{}` | no |
| rule\_forward\_attachement\_ids | IDs of the forward resolver rules that should be attached to the rule_forward_vpc_attachement_ids. If not specify, the forward rules created by this module will be used for all the attachments. | list | `[]` | no |
| rule\_forward\_attachement\_ids\_count | How many var.rule_forward_attachement_ids. This value cannot be computed automatically in Terraform 0.11. | string | `"0"` | no |
| rule\_forward\_count | How many resolvers forward rules to be created in the module. This value cannot be computed automatically in Terraform 0.11. | string | `"0"` | no |
| rule\_forward\_domain\_names | Domain names of the resolvers forward rules to be created in the module. DNS queries for these domain names are forwarded to the IP addresses that are specified using target_ip. | list | `[]` | no |
| rule\_forward\_names | Names of the resolvers forward rules to be created in the module. Friendly names that lets you easily find a rule in the Resolver dashboard in the Route 53 console. | list | `[]` | no |
| rule\_forward\_resolver\_endpoint\_ids | IDs of the resolver endpoints to be used for the resolver forward rules. If not specify, the first OUBOUND resolver created by this module will be used for all the rules. | list | `[]` | no |
| rule\_forward\_resolver\_target\_ips | Object of lists of objects containing target IPs for the resolver forward rules. IPs that you want resolvers to forward DNS queries to. Look at examples for correct usage. | map | `{}` | no |
| rule\_forward\_share\_indexes | Indexes of the forward rules to be shared with other principals (rule_forward_share_principals). See examples for correct usage. | list | `[]` | no |
| rule\_forward\_share\_names | Names of the resource shares resolvers for forward rules to be created in the module. | list | `[]` | no |
| rule\_forward\_share\_principal\_count | How many accounts must receive the resource shares for forward rules to be created in the module. This value cannot be computed automatically in Terraform 0.11. | string | `"0"` | no |
| rule\_forward\_share\_principals | IDs of the accounts that must receive the resource shares for forward rules to be created in the module. | list | `[]` | no |
| rule\_forward\_share\_tags | Tags specific to the resource shares for the forward rules to be created in the module. Will be merged with tags. | map | `{}` | no |
| rule\_forward\_tags | Tags specific to the resolvers forward rules to be created in the module. Will be merged with tags. | map | `{}` | no |
| rule\_forward\_vpc\_attachement\_count | How many resolver forward rule attachments should be created in the module. This value cannot be computed automatically in Terraform 0.11. | string | `"0"` | no |
| rule\_forward\_vpc\_attachement\_ids | IDs of the VPC to be attached to the resolver forward rules of this module. | list | `[]` | no |
| tags | Tags to be shared among all resources of this module. | map | `{}` | no |
| vpc\_id | ID of the VPC where to create resources for this module. | string | `""` | no |
| zone\_private\_comments | Comments of private hosted zones to be created in the module. | list | `[]` | no |
| zone\_private\_count | How many private hosted zones should be created in the module. This value cannot be computed automatically in Terraform 0.11. | string | `"0"` | no |
| zone\_private\_ids | IDs of existing private hosted zones to be used. If not specified, the module will create a new hosted zones according to other variables. | list | `[]` | no |
| zone\_private\_ids\_count | How many existing private IDs of private hosted zones are passed. This value cannot be computed automatically in Terraform 0.11. | string | `"0"` | no |
| zone\_private\_names | Names of private hosted zones to be created in the module. | list | `[]` | no |
| zone\_private\_vpc\_attachement\_count | How many private hosted zones attachments should be created in the module. This should not contain the current VPC. This value cannot be computed automatically in Terraform 0.11. | string | `"0"` | no |
| zone\_private\_vpc\_attachement\_ids | IDs of the VPC to be attached to the private hosted zones of this module. This should not contain the current VPC as it will be attached automatically. | list | `[]` | no |
| zone\_public\_comments | Comments of public hosted zones to be created in the module. | list | `[]` | no |
| zone\_public\_count | How many public hosted zones should be created in the module. This value cannot be computed automatically in Terraform 0.11. | string | `"0"` | no |
| zone\_public\_names | Names of public hosted zones to be created in the module. | list | `[]` | no |
| zone\_tags | Tags specific to the hosted zones to be created in the module. Will be merged with tags. | map | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| principal\_association\_forward\_id | The Amazon Resource Name (ARN) of the Resource Share and the principal, separated by a comma. |
| record\_fqdns | FQDNs built using the zone domains and names of the records. |
| record\_names | Names of the records. |
| resolver\_inbound\_arns | ID of the security group shared with the INBOUND resolvers. |
| resolver\_inbound\_host\_vpc\_ids | IDs of the host VPC of the the INBOUND resolvers. |
| resolver\_inbound\_ids | ID of the security group shared with the INBOUND resolvers. |
| resolver\_inbound\_security\_group\_ids | IDs of the security group for the INBOUND resolvers. |
| resolver\_outbound\_arns | ID of the security group shared with the OUTBOUND resolvers. |
| resolver\_outbound\_host\_vpc\_ids | IDs of the host VPC of the the OUTBOUND resolvers. |
| resolver\_outbound\_ids | ID of the security group shared with the OUTBOUND resolvers. |
| resolver\_outbound\_security\_group\_id | ID of the security group shared with the OUTBOUND resolvers. |
| resource\_association\_forward\_id | The Amazon Resource Name (ARN) of the resource share. |
| rule\_association\_forward\_id | The ID of the resolver rule association. |
| rule\_forward\_arns | ARNs of the resolver rules. |
| rule\_forward\_ids | IDs of the resolver rules. |
| rule\_forward\_owner\_ids | When the rules are shared with other AWS accounts, the account IDs of the accounts that the rules are shared with. |
| rule\_forward\_share\_arns | ARNs of the resource shares for the resolver forward rules. |
| rule\_forward\_share\_ids | IDs of the resource shares for the resolver forward rules. |
| rule\_forward\_share\_statuses | Whether the rules are shared and, if so, whether the current account is sharing the rules with other accounts, or another account is sharing the rules with the current account. Values are NOT_SHARED, SHARED_BY_ME or SHARED_WITH_ME. |
| zone\_association\_private\_id | The calculated unique identifier for the association. |
| zone\_association\_private\_vpc\_id | The ID of the VPC for the association. |
| zone\_association\_private\_vpc\_region | The region in which the VPC identified by vpc_id was created. |
| zone\_association\_private\_zone\_id | The ID of the hosted zone for the association. |
| zone\_private\_ids | IDs of the private hosted zones. |
| zone\_private\_name\_servers | A list of name servers in associated (or default) delegation set. |
| zone\_public\_ids | IDs of the public hosted zones. |
| zone\_public\_name\_servers | A list of name servers in associated (or default) delegation set. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
