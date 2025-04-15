# © 2024 Amazon Web Services, Inc. or its affiliates. All Rights Reserved.
# 
# This AWS Content is provided subject to the terms of the AWS Customer Agreement
# available at http://aws.amazon.com/agreement or other written agreement between
# Customer and either Amazon Web Services, Inc. or Amazon Web Services EMEA SARL or both.

data "aws_organizations_organization" "this" {}
data "aws_region" "current" {}

locals {

  ous_first_level = { for ou_path, ou_value in var.organizational_units : ou_path => {
    name        = basename(ou_path)
    parent_path = dirname(ou_path)
    scp         = ou_value.scp
    tag         = ou_value.tag
    ct_register = ou_value.ct_register
    ct_control  = ou_value.ct_control
    } if length(split("/", ou_path)) == 2
  }

  ous_second_level = { for ou_path, ou_value in var.organizational_units : ou_path => {
    name        = basename(ou_path)
    parent_path = dirname(ou_path)
    scp         = ou_value.scp
    tag         = ou_value.tag
    ct_register = ou_value.ct_register
    ct_control  = ou_value.ct_control
    } if length(split("/", ou_path)) == 3
  }

  ous_third_level = { for ou_path, ou_value in var.organizational_units : ou_path => {
    name        = basename(ou_path)
    parent_path = dirname(ou_path)
    scp         = ou_value.scp
    tag         = ou_value.tag
    ct_register = ou_value.ct_register
    ct_control  = ou_value.ct_control
    } if length(split("/", ou_path)) == 4
  }

  ous_fourth_level = { for ou_path, ou_value in var.organizational_units : ou_path => {
    name        = basename(ou_path)
    parent_path = dirname(ou_path)
    scp         = ou_value.scp
    tag         = ou_value.tag
    ct_register = ou_value.ct_register
    ct_control  = ou_value.ct_control
    } if length(split("/", ou_path)) == 5
  }

  ous_fifth_level = { for ou_path, ou_value in var.organizational_units : ou_path => {
    name        = basename(ou_path)
    parent_path = dirname(ou_path)
    scp         = ou_value.scp
    tag         = ou_value.tag
    ct_register = ou_value.ct_register
    ct_control  = ou_value.ct_control
    } if length(split("/", ou_path)) == 6
  }

  scps         = distinct(flatten([for ou_path, ou_value in var.organizational_units : ou_value.scp if ou_value.scp != null]))
  tag_policies = distinct(flatten([for ou_path, ou_value in var.organizational_units : ou_value.tag if ou_value.tag != null]))

  scp_per_ou_first_level = merge([for ou_path, ou_value in local.ous_first_level : {
    for scp in ou_value.scp : "${ou_path}/${scp}" => {
      ou  = ou_path
      scp = scp
    }
    }
  ]...)

  scp_per_ou_second_level = merge([for ou_path, ou_value in local.ous_second_level : {
    for scp in ou_value.scp : "${ou_path}/${scp}" => {
      ou  = ou_path
      scp = scp
    }
    }
  ]...)

  scp_per_ou_third_level = merge([for ou_path, ou_value in local.ous_third_level : {
    for scp in ou_value.scp : "${ou_path}/${scp}" => {
      ou  = ou_path
      scp = scp
    }
    }
  ]...)

  scp_per_ou_fourth_level = merge([for ou_path, ou_value in local.ous_fourth_level : {
    for scp in ou_value.scp : "${ou_path}/${scp}" => {
      ou  = ou_path
      scp = scp
    }
    }
  ]...)

  scp_per_ou_fifth_level = merge([for ou_path, ou_value in local.ous_fifth_level : {
    for scp in ou_value.scp : "${ou_path}/${scp}" => {
      ou  = ou_path
      scp = scp
    }
    }
  ]...)



  tag_per_ou_first_level = merge([for ou_path, ou_value in local.ous_first_level : {
    for tag in ou_value.tag : "${ou_path}/${tag}" => {
      ou  = ou_path
      tag = tag
    }
    }
  ]...)

  tag_per_ou_second_level = merge([for ou_path, ou_value in local.ous_second_level : {
    for tag in ou_value.tag : "${ou_path}/${tag}" => {
      ou  = ou_path
      tag = tag
    }
    }
  ]...)

  tag_per_ou_third_level = merge([for ou_path, ou_value in local.ous_third_level : {
    for tag in ou_value.tag : "${ou_path}/${tag}" => {
      ou  = ou_path
      tag = tag
    }
    }
  ]...)

  tag_per_ou_fourth_level = merge([for ou_path, ou_value in local.ous_fourth_level : {
    for tag in ou_value.tag : "${ou_path}/${tag}" => {
      ou  = ou_path
      tag = tag
    }
    }
  ]...)

  tag_per_ou_fifth_level = merge([for ou_path, ou_value in local.ous_fifth_level : {
    for tag in ou_value.tag : "${ou_path}/${tag}" => {
      ou  = ou_path
      tag = tag
    }
    }
  ]...)

  ct_control_per_ou_first_level = merge([for ou_path, ou_value in local.ous_first_level : {
    for ct_control in ou_value.ct_control : "${ou_path}/${ct_control}" => {
      ou         = ou_path
      ct_control = ct_control
    }
    }
  ]...)

  ct_control_per_ou_second_level = merge([for ou_path, ou_value in local.ous_second_level : {
    for ct_control in ou_value.ct_control : "${ou_path}/${ct_control}" => {
      ou         = ou_path
      ct_control = ct_control
    }
    }
  ]...)

  ct_control_per_ou_third_level = merge([for ou_path, ou_value in local.ous_third_level : {
    for ct_control in ou_value.ct_control : "${ou_path}/${ct_control}" => {
      ou         = ou_path
      ct_control = ct_control
    }
    }
  ]...)

  ct_control_per_ou_fourth_level = merge([for ou_path, ou_value in local.ous_fourth_level : {
    for ct_control in ou_value.ct_control : "${ou_path}/${ct_control}" => {
      ou         = ou_path
      ct_control = ct_control
    }
    }
  ]...)

  ct_control_per_ou_fifth_level = merge([for ou_path, ou_value in local.ous_fifth_level : {
    for ct_control in ou_value.ct_control : "${ou_path}/${ct_control}" => {
      ou         = ou_path
      ct_control = ct_control
    }
    }
  ]...)
}
