# © 2024 Amazon Web Services, Inc. or its affiliates. All Rights Reserved.
# 
# This AWS Content is provided subject to the terms of the AWS Customer Agreement
# available at http://aws.amazon.com/agreement or other written agreement between
# Customer and either Amazon Web Services, Inc. or Amazon Web Services EMEA SARL or both.

variable "organizational_units" {
  description = "Hierarchy of OUs of the Organization. You must define each node of tree."
  type = map(object({
    scp         = optional(list(string), [])
    tag         = optional(list(string), [])
    ct_register = optional(bool, true)
    ct_control  = optional(list(string), [])
  }))

  default = {}
}

variable "org_readonly_accounts" {
  description = "List of accounts that are granted read access to AWS Organizations"
  type        = list(string)
  default     = []
}

variable "delegations" {
  description = "List of standard_delegations, specify the service as key and the account id"
  type        = map(string)

  default = {}
}

variable "enable_ram_sharing" {
  description = "Enable RAM sharing"
  type        = bool
  default     = true
}