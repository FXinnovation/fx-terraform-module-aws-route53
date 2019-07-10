provider "aws" {
  version    = "~> 2.18.0"
  region     = "eu-west-2"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}

resource "random_string" "this" {
  length  = 8
  upper   = false
  special = false
}

data "aws_vpc" "default" {
  default = true
}

resource "aws_vpc" "main" {
  cidr_block       = "10.1.1.0/24"
  instance_tenancy = "dedicated"
}

module "default_alternative" {
  source = "../../"

  #####
  # General
  #####

  enable = true
  tags = {
    Name = "${random_string.this.result}tftest"
  }
  vpc_id = "${data.aws_vpc.default.id}"

  #####
  # Hosted zone
  #####

  zone_public_count    = 1
  zone_public_names    = ["${random_string.this.result}.tftestpubexample.com"]
  zone_public_comments = ["An private zone for ${random_string.this.result}.tftestpubexample.com"]
  zone_private_count   = 3
  zone_private_names = [
    "${random_string.this.result}tftestexample.com",
    "${random_string.this.result}tftest2example.com",
    "${random_string.this.result}tftest3example.com",
  ]
  zone_private_comments = [
    "An private zone for ${random_string.this.result}.tftestexample.com",
    "An private zone for ${random_string.this.result}.tftest2example.com",
    "An private zone for ${random_string.this.result}.tftest3example.com",
  ]
  zone_private_vpc_attachement_count = 1
  zone_private_vpc_attachement_ids   = ["${aws_vpc.main.id}"]
  zone_tags = {
    Name = "${random_string.this.result}tftest"
  }
}
