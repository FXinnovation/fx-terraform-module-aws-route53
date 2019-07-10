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
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| access\_key |  | string | n/a | yes |
| secret\_key |  | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| route53\_zone\_private\_ids |  |
| route53\_zone\_public\_ids |  |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
