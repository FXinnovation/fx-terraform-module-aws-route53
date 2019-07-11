#####
# General
#####

variable "enable" {
  description = "Whether or not to enable this entire module or not."
  default     = true
}

variable "tags" {
  description = "Tags to be shared among all resources of this module."
  default     = {}
}

variable "vpc_id" {
  description = "ID of the VPC where to create resources for this module."
  default     = ""
}

#####
# Hosted zone
#####

variable "zone_public_count" {
  description = "How many public hosted zones should be created in the module. This value cannot be computed automatically in Terraform 0.11."
  default     = 0
}

variable "zone_public_names" {
  description = "Names of public hosted zones to be created in the module."
  default     = []
}

variable "zone_public_comments" {
  description = "Comments of public hosted zones to be created in the module."
  default     = []
}

variable "zone_tags" {
  description = "Tags specific to the hosted zones to be created in the module. Will be merged with tags."
  default     = {}
}

variable "zone_private_count" {
  description = "How many private hosted zones should be created in the module. This value cannot be computed automatically in Terraform 0.11."
  default     = 0
}

variable "zone_private_names" {
  description = "Names of private hosted zones to be created in the module."
  default     = []
}

variable "zone_private_comments" {
  description = "Comments of private hosted zones to be created in the module."
  default     = []
}

variable "zone_private_vpc_attachement_count" {
  description = "How many private hosted zones attachments should be created in the module. This should not contain the current VPC. This value cannot be computed automatically in Terraform 0.11."
  default     = 0
}

variable "zone_private_vpc_attachement_ids" {
  description = "IDs of the VPC to be attached to the private hosted zones of this module. This should not contain the current VPC as it will be attached automatically."
  default     = []
}

#####
# Resolver endpoints inbound
#####

variable "resolver_tags" {
  description = "Tags specific to the resolvers to be created in the module. Will be merged with tags."
  default     = {}
}

variable "resolver_inbound_count" {
  description = "How many INBOUND resolvers to be created in the module. This value cannot be computed automatically in Terraform 0.11."
  default     = 0
}

variable "resolver_inbound_names" {
  description = "Names of the INBOUND resolvers to be created in the module."
  default     = []
}

variable "resolver_inbound_ip_addresses" {
  description = "Object of lists containing the IP addresses corresponding to the subnet IDs for the INBOUND resolvers to be created in the module. Look at examples for correct usage."
  default     = {}
}

variable "resolver_inbound_subnet_ids" {
  description = "Object of lists containing the subnet IDs corresponding to the IP addresses for the INBOUND resolvers to be created in the module. Look at examples for correct usage."
  default     = {}
}

variable "resolver_inbound_security_group_name" {
  description = "Name of the security groups shared for INBOUND resolvers."
  default     = "inbound-resolver"
}

variable "resolver_inbound_security_group_allowed_cidrs" {
  description = "CIDRs allowed to perform DNS request to the INBOUND resolvers."
  default     = ["10.0.0.0/8"]
}

#####
# Resolver endpoints outbound
#####

variable "resolver_outbound_count" {
  description = "How many OUTBOUND resolvers to be created in the module. This value cannot be computed automatically in Terraform 0.11."
  default     = 0
}

variable "resolver_outbound_names" {
  description = "Names of the OUTBOUND resolvers to be created in the module."
  default     = []
}

variable "resolver_outbound_ip_addresses" {
  description = "Object of lists containing the IP addresses corresponding to the subnet IDs for the OUTBOUND resolvers to be created in the module. Look at examples for correct usage."
  default     = {}
}

variable "resolver_outbound_subnet_ids" {
  description = "Object of lists containing the subnet IDs corresponding to the IP addresses for the OUTBOUND resolvers to be created in the module. Look at examples for correct usage."
  default     = {}
}

variable "resolver_outbound_security_group_name" {
  description = "Name of the security groups shared for OUTBOUND resolvers."
  default     = "outbound-resolver"
}

variable "resolver_outbound_security_group_allowed_cidrs" {
  description = "CIDRs allowed to perform DNS request to the OUTBOUND resolvers."
  default     = ["10.0.0.0/8"]
}

#####
# Forward rules
#####

variable "rule_forward_count" {
  description = "How many resolvers forward rules to be created in the module. This value cannot be computed automatically in Terraform 0.11."
  default     = 0
}

variable "rule_forward_domain_names" {
  description = "Domain names of the resolvers forward rules to be created in the module. DNS queries for these domain names are forwarded to the IP addresses that are specified using target_ip."
  default     = []
}

variable "rule_forward_names" {
  description = "Names of the resolvers forward rules to be created in the module. Friendly names that lets you easily find a rule in the Resolver dashboard in the Route 53 console."
  default     = []
}

variable "rule_forward_resolver_endpoint_ids" {
  description = "IDs of the resolver endpoints to be used for the resolver forward rules. If not specify, the first OUBOUND resolver created by this module will be used for all the rules."
  default     = []
}

variable "rule_forward_resolver_target_ips" {
  description = "Object of lists of objects containing target IPs for the resolver forward rules. IPs that you want resolvers to forward DNS queries to. Look at examples for correct usage."
  default     = {}
}

variable "rule_forward_tags" {
  description = "Tags specific to the resolvers forward rules to be created in the module. Will be merged with tags."
  default     = {}
}

variable "rule_forward_vpc_attachement_count" {
  description = "How many resolver forward rule attachments should be created in the module. This should not contain the current VPC. This value cannot be computed automatically in Terraform 0.11."
  default     = 0
}

variable "rule_forward_vpc_attachement_ids" {
  description = "IDs of the VPC to be attached to the resolver forward rules of this module. This should not contain the current VPC as it will be attached automatically."
  default     = []
}
