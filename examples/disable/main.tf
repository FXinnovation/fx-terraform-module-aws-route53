provider "aws" {
  version    = "~> 2.18.0"
  region     = "eu-west-2"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}

module "disable" {
  source = "../../"

  enable = false
}
