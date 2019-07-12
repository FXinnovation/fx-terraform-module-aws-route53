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

resource "random_string" "num" {
  length  = 2
  upper   = false
  lower   = false
  special = false
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet" "sub1" {
  vpc_id     = "${data.aws_vpc.default.id}"
  cidr_block = "172.31.0.0/20"
}

data "aws_subnet" "sub2" {
  vpc_id     = "${data.aws_vpc.default.id}"
  cidr_block = "172.31.16.0/20"
}

resource "aws_vpc" "main" {
  cidr_block = "10.1.1.0/24"
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
  # Resolvers inbound
  #####

  resolver_tags = {
    Name = "${random_string.this.result}tftest"
  }
  resolver_inbound_count = 1
  resolver_inbound_names = ["${random_string.this.result}inResolver"]
  resolver_inbound_ip_addresses = {
    "0" = [
      "172.31.0.${random_string.num.result}",
      "172.31.16.${random_string.num.result}",
    ]
  }
  resolver_inbound_subnet_ids = {
    "0" = [
      "${data.aws_subnet.sub1.id}",
      "${data.aws_subnet.sub2.id}",
    ]
  }
  resolver_inbound_security_group_name          = "${random_string.this.result}inResolver"
  resolver_inbound_security_group_allowed_cidrs = ["192.168.0.0/16", "10.0.0.0/8"]

  #####
  # Resolvers outbound
  #####

  resolver_outbound_count = 1
  resolver_outbound_names = ["${random_string.this.result}outResolver"]
  resolver_outbound_ip_addresses = {
    "0" = [
      "172.31.1.${random_string.num.result}",
      "172.31.17.${random_string.num.result}",
    ]
  }
  resolver_outbound_subnet_ids = {
    "0" = [
      "${data.aws_subnet.sub1.id}",
      "${data.aws_subnet.sub2.id}",
    ]
  }
  resolver_outbound_security_group_name          = "${random_string.this.result}outResolver"
  resolver_outbound_security_group_allowed_cidrs = ["192.168.0.0/16", "10.0.0.0/8"]

  #####
  # Forward rules
  #####

  rule_forward_count        = 1
  rule_forward_domain_names = ["${random_string.this.result}.tftest-rule-example.com"]
  rule_forward_names        = ["${random_string.this.result}ruleForward"]
  rule_forward_resolver_target_ips = {
    "0" = [
      {
        ip = "123.45.67.${random_string.num.result}"
      },
      {
        ip = "123.45.67.${random_string.num.result}"
      },
    ]
  }
  rule_forward_tags = {
    Name = "${random_string.this.result}tftest"
  }
  rule_forward_vpc_attachement_count = 2
  rule_forward_vpc_attachement_ids   = ["${aws_vpc.main.id}", "${aws_vpc.second.id}"]
}
