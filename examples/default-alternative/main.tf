provider "aws" {
  version    = "~> 2"
  region     = "eu-west-2"
  access_key = var.access_key
  secret_key = var.secret_key

  assume_role {
    role_arn     = "arn:aws:iam::700633540182:role/OrganizationAccountAccessRole"
    session_name = "TfTest"
  }
}

resource "random_string" "this" {
  length  = 8
  upper   = false
  special = false
}

resource "random_integer" "this" {
  min = 4
  max = 254
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet" "sub1" {
  vpc_id     = data.aws_vpc.default.id
  cidr_block = "172.31.0.0/20"
}

data "aws_subnet" "sub2" {
  vpc_id     = data.aws_vpc.default.id
  cidr_block = "172.31.16.0/20"
}

resource "aws_vpc" "main" {
  cidr_block = "10.1.0.0/16"
}

resource "aws_subnet" "main_sub1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.1.0.0/20"
}

resource "aws_subnet" "main_sub2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.1.16.0/20"
}

resource "aws_elb" "main" {
  name               = "${random_string.this.result}tftest"
  availability_zones = ["eu-west-2b"]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
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
  vpc_id = data.aws_vpc.default.id

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
  zone_private_vpc_attachement_count = 0
  zone_private_vpc_attachement_ids   = []
  zone_tags = {
    Name = "${random_string.this.result}tftest"
  }

  #####
  # Resolvers inbound
  #####

  resolver_tags = {
    Name = "${random_string.this.result}tftest"
  }
  resolver_inbound_count = 2
  resolver_inbound_names = ["${random_string.this.result}inResolver1", "${random_string.this.result}inResolver2"]
  resolver_inbound_ip_addresses = {
    "0" = [
      format("172.31.0.%s", random_integer.this.result),
      format("172.31.16.%s", random_integer.this.result),
    ]
    "1" = [
      format("10.1.0.%s", random_integer.this.result),
      format("10.1.16.%s", random_integer.this.result),
    ]
  }
  resolver_inbound_subnet_ids = {
    "0" = [
      data.aws_subnet.sub1.id,
      data.aws_subnet.sub2.id,
    ]
    "1" = [
      aws_subnet.main_sub1.id,
      aws_subnet.main_sub2.id,
    ]
  }
  resolver_inbound_security_group_name                  = "${random_string.this.result}inResolver"
  resolver_inbound_security_group_ingress_allowed_cidrs = ["192.168.0.0/16", "10.0.0.0/8"]

  #####
  # Resolvers outbound
  #####

  resolver_outbound_count = 2
  resolver_outbound_names = ["${random_string.this.result}outResolver"]
  resolver_outbound_ip_addresses = {
    "0" = [
      format("172.31.1.%s", random_integer.this.result),
      format("172.31.17.%s", random_integer.this.result),
    ]
    "1" = [
      format("10.1.1.%s", random_integer.this.result),
      format("10.1.17.%s", random_integer.this.result),
    ]
  }
  resolver_outbound_subnet_ids = {
    "0" = [
      data.aws_subnet.sub1.id,
      data.aws_subnet.sub2.id,
    ]
    "1" = [
      aws_subnet.main_sub1.id,
      aws_subnet.main_sub2.id,
    ]
  }
  resolver_outbound_security_group_name                  = "${random_string.this.result}outResolver"
  resolver_outbound_security_group_ingress_allowed_cidrs = ["192.168.0.0/16", "10.0.0.0/8"]

  #####
  # Forward rules
  #####

  rule_forward_count = 2
  rule_forward_domain_names = [
    "${random_string.this.result}.tftest-rule-example.com",
    "${random_string.this.result}.tftest2-rule-example.com",
  ]
  rule_forward_names = [
    "${random_string.this.result}ruleForward",
    "${random_string.this.result}ruleForward2",
  ]
  rule_forward_resolver_target_ips = {
    "0" = [
      {
        ip = "123.45.1.10"
      },
      {
        ip = "123.45.1.16"
      },
    ]
    "1" = [
      {
        ip = "123.45.2.10"
      },
      {
        ip = "123.45.2.16"
      },
    ]
  }
  rule_forward_tags = {
    Name = "${random_string.this.result}tftest"
  }
  rule_forward_vpc_attachement_count = 0

  #####
  # Resource share
  #####

  rule_forward_share_indexes = [0, 1]
  rule_forward_share_names   = ["${random_string.this.result}resShare1", "${random_string.this.result}resShare2"]
  rule_forward_share_tags = {
    Name = "${random_string.this.result}tftest"
  }
  rule_forward_share_principal_count = 1
  rule_forward_share_principals      = ["203977111394"]

  #####
  # Records alias
  #####

  record_alias_zone_indexes = [2]
  record_alias_domain_names = [
    "record.${random_string.this.result}tftest3example.com",
  ]
  record_alias_types            = ["A"]
  record_alias_dns_names        = [aws_elb.main.dns_name]
  record_alias_zone_id          = [aws_elb.main.zone_id]
  record_alias_evaluate_healths = [true]
}

module "default_alternative2" {
  source = "../../"

  zone_private_count                 = 1
  zone_private_ids_count             = 1
  zone_private_ids                   = [element(module.default_alternative.zone_private_ids, 0)]
  zone_private_vpc_attachement_count = 1
  zone_private_vpc_attachement_ids   = [aws_vpc.main.id]

  rule_forward_count                 = 2
  rule_forward_attachement_ids_count = 1
  rule_forward_attachement_ids       = [module.default_alternative.rule_forward_ids]
  rule_forward_vpc_attachement_count = 1
  rule_forward_vpc_attachement_ids   = [data.aws_vpc.default.id]
}

