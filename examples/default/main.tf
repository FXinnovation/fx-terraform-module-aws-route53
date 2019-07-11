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

data "aws_subnet_ids" "default" {
  vpc_id = "${data.aws_vpc.default.id}"
}

resource "aws_vpc" "main" {
  cidr_block       = "10.1.1.0/24"
  instance_tenancy = "dedicated"
}

resource "aws_vpc" "second" {
  cidr_block       = "10.1.2.0/24"
  instance_tenancy = "dedicated"
}

module "default" {
  source = "../../"

  enable = true

  tags = {
    Name = "${random_string.this.result}tftest"
  }

  vpc_id = "${data.aws_vpc.default.id}"

  #####
  # Hosted zone
  #####

  zone_public_count                  = 1
  zone_public_names                  = ["${random_string.this.result}.tftestpubexample.com"]
  zone_public_comments               = ["An private zone for ${random_string.this.result}.tftestpubexample.com"]
  zone_private_count                 = 1
  zone_private_names                 = ["tftestexample.com"]
  zone_private_comments              = ["An private zone for ${random_string.this.result}.tftestexample.com"]
  zone_private_vpc_attachement_count = 2
  zone_private_vpc_attachement_ids   = ["${aws_vpc.main.id}", "${aws_vpc.second.id}"]
  zone_tags = {
    Name = "${random_string.this.result}tftest"
  }

  #####
  # Resolvers
  #####

  resolver_tags = {
    Name = "${random_string.this.result}tftest"
  }
  resolver_inbound_count = 1
  resolver_inbound_names = ["${random_string.this.result}inResolver"]
  resolver_inbound_ip_addresses = {
    "0" = [
      "172.31.32.5",
      "172.31.0.5",
    ]
  }
  resolver_inbound_subnet_ids = {
    "0" = [
      "${element(data.aws_subnet_ids.default.ids, 0)}",
      "${element(data.aws_subnet_ids.default.ids, 1)}",
    ]
  }
  resolver_inbound_security_group_name          = "${random_string.this.result}inResolver"
  resolver_inbound_security_group_allowed_cidrs = ["192.168.0.0/16", "10.0.0.0/8"]
}
