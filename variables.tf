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

variable "zone_pubic_names" {
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
