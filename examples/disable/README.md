# Route53 module disabled test

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |
| aws | ~> 2 |

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| access\_key | n/a | `string` | n/a | yes |
| secret\_key | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| route53\_principal\_association\_forward\_id | The Amazon Resource Name (ARN) of the Resource Share and the principal, separated by a comma. |
| route53\_record\_fqdns | FQDNs built using the zone domains and names of the records. |
| route53\_record\_names | Names of the records. |
| route53\_resolver\_inbound\_arns | ID of the security group shared with the INBOUND resolvers. |
| route53\_resolver\_inbound\_host\_vpc\_ids | IDs of the host VPC of the the INBOUND resolvers. |
| route53\_resolver\_inbound\_ids | ID of the security group shared with the INBOUND resolvers. |
| route53\_resolver\_inbound\_security\_group\_ids | IDs of the security group for the INBOUND resolvers. |
| route53\_resolver\_outbound\_arns | ID of the security group shared with the OUTBOUND resolvers. |
| route53\_resolver\_outbound\_host\_vpc\_ids | IDs of the host VPC of the the OUTBOUND resolvers. |
| route53\_resolver\_outbound\_ids | ID of the security group shared with the OUTBOUND resolvers. |
| route53\_resolver\_outbound\_security\_group\_id | ID of the security group shared with the OUTBOUND resolvers. |
| route53\_resource\_association\_forward\_id | The Amazon Resource Name (ARN) of the resource share. |
| route53\_rule\_association\_forward\_id | The ID of the resolver rule association. |
| route53\_rule\_forward\_arns | ARNs of the resolver rules. |
| route53\_rule\_forward\_ids | IDs of the resolver rules. |
| route53\_rule\_forward\_owner\_ids | When the rules are shared with other AWS accounts, the account IDs of the accounts that the rules are shared with. |
| route53\_rule\_forward\_share\_arns | ARNs of the resource shares for the resolver forward rules. |
| route53\_rule\_forward\_share\_ids | IDs of the resource shares for the resolver forward rules. |
| route53\_rule\_forward\_share\_statuses | Whether the rules are shared and, if so, whether the current account is sharing the rules with other accounts, or another account is sharing the rules with the current account. Values are NOT\_SHARED, SHARED\_BY\_ME or SHARED\_WITH\_ME. |
| route53\_zone\_association\_private\_id | The calculated unique identifier for the association. |
| route53\_zone\_association\_private\_vpc\_id | The ID of the VPC for the association. |
| route53\_zone\_association\_private\_vpc\_region | The region in which the VPC identified by vpc\_id was created. |
| route53\_zone\_association\_private\_zone\_id | The ID of the hosted zone for the association. |
| route53\_zone\_private\_ids | IDs of the private hosted zones. |
| route53\_zone\_private\_name\_servers | A list of name servers in associated (or default) delegation set. |
| route53\_zone\_public\_ids | IDs of the public hosted zones. |
| route53\_zone\_public\_name\_servers | A list of name servers in associated (or default) delegation set. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
