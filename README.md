# Terraform Route53 module

This module is not to be deployed directly.

Limitations:
- All resolvers of the same type shares the same security group rules.
- All resolvers must have an exact number of 2 IPs. This cannot be worked around in Terraform 0.11.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| enable | Whether or not to enable this entire module or not. | string | `"true"` | no |
| resolver\_inbound\_count | How many INBOUND resolvers to be created in the module. This value cannot be computed automatically in Terraform 0.11. | string | `"0"` | no |
| resolver\_inbound\_ip\_addresses | Object of lists containing the IP addresses corresponding to the subnet IDs for the INBOUND resolvers to be created in the module. Look at examples for correct usage. | map | `{}` | no |
| resolver\_inbound\_names | Names of the INBOUND resolvers to be created in the module. | list | `[]` | no |
| resolver\_inbound\_security\_group\_allowed\_cidrs | CIDRs allowed to perform DNS request to the INBOUND resolvers. | list | `[ "10.0.0.0/8" ]` | no |
| resolver\_inbound\_security\_group\_name | Name of the security groups shared for INBOUND resolvers. | string | `"inbound-resolver"` | no |
| resolver\_inbound\_subnet\_ids | Object of lists containing the subnet IDs corresponding to the IP addresses for the INBOUND resolvers to be created in the module. Look at examples for correct usage. | map | `{}` | no |
| resolver\_outbound\_count | How many OUTBOUND resolvers to be created in the module. This value cannot be computed automatically in Terraform 0.11. | string | `"0"` | no |
| resolver\_outbound\_ip\_addresses | Object of lists containing the IP addresses corresponding to the subnet IDs for the OUTBOUND resolvers to be created in the module. Look at examples for correct usage. | map | `{}` | no |
| resolver\_outbound\_names | Names of the OUTBOUND resolvers to be created in the module. | list | `[]` | no |
| resolver\_outbound\_security\_group\_allowed\_cidrs | CIDRs allowed to perform DNS request to the OUTBOUND resolvers. | list | `[ "10.0.0.0/8" ]` | no |
| resolver\_outbound\_security\_group\_name | Name of the security groups shared for OUTBOUND resolvers. | string | `"outbound-resolver"` | no |
| resolver\_outbound\_subnet\_ids | Object of lists containing the subnet IDs corresponding to the IP addresses for the OUTBOUND resolvers to be created in the module. Look at examples for correct usage. | map | `{}` | no |
| resolver\_tags | Tags specific to the resolvers to be created in the module. Will be merged with tags. | map | `{}` | no |
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
| rule\_forward\_vpc\_attachement\_count | How many resolver forward rule attachments should be created in the module. This should not contain the current VPC. This value cannot be computed automatically in Terraform 0.11. | string | `"0"` | no |
| rule\_forward\_vpc\_attachement\_ids | IDs of the VPC to be attached to the resolver forward rules of this module. This should not contain the current VPC as it will be attached automatically. | list | `[]` | no |
| tags | Tags to be shared among all resources of this module. | map | `{}` | no |
| vpc\_id | ID of the VPC where to create resources for this module. | string | `""` | no |
| zone\_private\_comments | Comments of private hosted zones to be created in the module. | list | `[]` | no |
| zone\_private\_count | How many private hosted zones should be created in the module. This value cannot be computed automatically in Terraform 0.11. | string | `"0"` | no |
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
| resolver\_inbound\_arns | ID of the security group shared with the INBOUND resolvers. |
| resolver\_inbound\_host\_vpc\_ids | IDs of the host VPC of the the INBOUND resolvers. |
| resolver\_inbound\_ids | ID of the security group shared with the INBOUND resolvers. |
| resolver\_inbound\_security\_group\_ids | IDs of the security group for the INBOUND resolvers. |
| resolver\_outbound\_arns | ID of the security group shared with the OUTBOUND resolvers. |
| resolver\_outbound\_host\_vpc\_ids | IDs of the host VPC of the the OUTBOUND resolvers. |
| resolver\_outbound\_ids | ID of the security group shared with the OUTBOUND resolvers. |
| resolver\_outbound\_security\_group\_id | ID of the security group shared with the OUTBOUND resolvers. |
| rule\_forward\_arns | ARNs of the resolver rules. |
| rule\_forward\_ids | IDs of the resolver rules. |
| rule\_forward\_owner\_ids | When the rules are shared with other AWS accounts, the account IDs of the accounts that the rules are shared with. |
| rule\_forward\_share\_statuses | Whether the rules are shared and, if so, whether the current account is sharing the rules with other accounts, or another account is sharing the rules with the current account. Values are NOT_SHARED, SHARED_BY_ME or SHARED_WITH_ME. |
| zone\_private\_ids | IDs of the private hosted zones. |
| zone\_public\_ids | IDs of the public hosted zones. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
