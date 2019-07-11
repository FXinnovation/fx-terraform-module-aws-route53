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
# Resolver endpoints
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
