# Route53 module default test

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which can cost money (AWS Elastic IP, for example). Run `terraform destroy` when you don't need these resources.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 2 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_default_alternative"></a> [default\_alternative](#module\_default\_alternative) | ../../ | n/a |
| <a name="module_default_alternative2"></a> [default\_alternative2](#module\_default\_alternative2) | ../../ | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_elb.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elb) | resource |
| [aws_subnet.main_sub1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.main_sub2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [random_integer.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |
| [random_string.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [aws_subnet.sub1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_subnet.sub2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_vpc.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_key"></a> [access\_key](#input\_access\_key) | n/a | `string` | n/a | yes |
| <a name="input_secret_key"></a> [secret\_key](#input\_secret\_key) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_route53_principal_association_forward_id"></a> [route53\_principal\_association\_forward\_id](#output\_route53\_principal\_association\_forward\_id) | The Amazon Resource Name (ARN) of the Resource Share and the principal, separated by a comma. |
| <a name="output_route53_record_fqdns"></a> [route53\_record\_fqdns](#output\_route53\_record\_fqdns) | FQDNs built using the zone domains and names of the records. |
| <a name="output_route53_record_names"></a> [route53\_record\_names](#output\_route53\_record\_names) | Names of the records. |
| <a name="output_route53_resolver_inbound_arns"></a> [route53\_resolver\_inbound\_arns](#output\_route53\_resolver\_inbound\_arns) | ID of the security group shared with the INBOUND resolvers. |
| <a name="output_route53_resolver_inbound_host_vpc_ids"></a> [route53\_resolver\_inbound\_host\_vpc\_ids](#output\_route53\_resolver\_inbound\_host\_vpc\_ids) | IDs of the host VPC of the the INBOUND resolvers. |
| <a name="output_route53_resolver_inbound_ids"></a> [route53\_resolver\_inbound\_ids](#output\_route53\_resolver\_inbound\_ids) | ID of the security group shared with the INBOUND resolvers. |
| <a name="output_route53_resolver_inbound_security_group_ids"></a> [route53\_resolver\_inbound\_security\_group\_ids](#output\_route53\_resolver\_inbound\_security\_group\_ids) | IDs of the security group for the INBOUND resolvers. |
| <a name="output_route53_resolver_outbound_arns"></a> [route53\_resolver\_outbound\_arns](#output\_route53\_resolver\_outbound\_arns) | ID of the security group shared with the OUTBOUND resolvers. |
| <a name="output_route53_resolver_outbound_host_vpc_ids"></a> [route53\_resolver\_outbound\_host\_vpc\_ids](#output\_route53\_resolver\_outbound\_host\_vpc\_ids) | IDs of the host VPC of the the OUTBOUND resolvers. |
| <a name="output_route53_resolver_outbound_ids"></a> [route53\_resolver\_outbound\_ids](#output\_route53\_resolver\_outbound\_ids) | ID of the security group shared with the OUTBOUND resolvers. |
| <a name="output_route53_resolver_outbound_security_group_id"></a> [route53\_resolver\_outbound\_security\_group\_id](#output\_route53\_resolver\_outbound\_security\_group\_id) | ID of the security group shared with the OUTBOUND resolvers. |
| <a name="output_route53_resource_association_forward_id"></a> [route53\_resource\_association\_forward\_id](#output\_route53\_resource\_association\_forward\_id) | The Amazon Resource Name (ARN) of the resource share. |
| <a name="output_route53_rule_association_forward_id"></a> [route53\_rule\_association\_forward\_id](#output\_route53\_rule\_association\_forward\_id) | The ID of the resolver rule association. |
| <a name="output_route53_rule_forward_arns"></a> [route53\_rule\_forward\_arns](#output\_route53\_rule\_forward\_arns) | ARNs of the resolver rules. |
| <a name="output_route53_rule_forward_ids"></a> [route53\_rule\_forward\_ids](#output\_route53\_rule\_forward\_ids) | IDs of the resolver rules. |
| <a name="output_route53_rule_forward_owner_ids"></a> [route53\_rule\_forward\_owner\_ids](#output\_route53\_rule\_forward\_owner\_ids) | When the rules are shared with other AWS accounts, the account IDs of the accounts that the rules are shared with. |
| <a name="output_route53_rule_forward_share_arns"></a> [route53\_rule\_forward\_share\_arns](#output\_route53\_rule\_forward\_share\_arns) | ARNs of the resource shares for the resolver forward rules. |
| <a name="output_route53_rule_forward_share_ids"></a> [route53\_rule\_forward\_share\_ids](#output\_route53\_rule\_forward\_share\_ids) | IDs of the resource shares for the resolver forward rules. |
| <a name="output_route53_rule_forward_share_statuses"></a> [route53\_rule\_forward\_share\_statuses](#output\_route53\_rule\_forward\_share\_statuses) | Whether the rules are shared and, if so, whether the current account is sharing the rules with other accounts, or another account is sharing the rules with the current account. Values are NOT\_SHARED, SHARED\_BY\_ME or SHARED\_WITH\_ME. |
| <a name="output_route53_zone_association_private_id"></a> [route53\_zone\_association\_private\_id](#output\_route53\_zone\_association\_private\_id) | The calculated unique identifier for the association. |
| <a name="output_route53_zone_association_private_vpc_id"></a> [route53\_zone\_association\_private\_vpc\_id](#output\_route53\_zone\_association\_private\_vpc\_id) | The ID of the VPC for the association. |
| <a name="output_route53_zone_association_private_vpc_region"></a> [route53\_zone\_association\_private\_vpc\_region](#output\_route53\_zone\_association\_private\_vpc\_region) | The region in which the VPC identified by vpc\_id was created. |
| <a name="output_route53_zone_association_private_zone_id"></a> [route53\_zone\_association\_private\_zone\_id](#output\_route53\_zone\_association\_private\_zone\_id) | The ID of the hosted zone for the association. |
| <a name="output_route53_zone_private_ids"></a> [route53\_zone\_private\_ids](#output\_route53\_zone\_private\_ids) | IDs of the private hosted zones. |
| <a name="output_route53_zone_private_name_servers"></a> [route53\_zone\_private\_name\_servers](#output\_route53\_zone\_private\_name\_servers) | A list of name servers in associated (or default) delegation set. |
| <a name="output_route53_zone_public_ids"></a> [route53\_zone\_public\_ids](#output\_route53\_zone\_public\_ids) | IDs of the public hosted zones. |
| <a name="output_route53_zone_public_name_servers"></a> [route53\_zone\_public\_name\_servers](#output\_route53\_zone\_public\_name\_servers) | A list of name servers in associated (or default) delegation set. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
