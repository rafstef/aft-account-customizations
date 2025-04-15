locals {
  org_id = "o-xxxxxxx"
  existing_ous = {
    "/Aft"      = "ou-yyyyyyyy"
    "/Sandbox"  = "ou-yyyyyyyy"
    "/Security" = "ou-yyyyyyyy"
  }


  existing_ous_first_level = { for ou_path, ou_value in local.existing_ous : ou_path => {
    id = ou_value
    } if length(split("/", ou_path)) == 2
  }

  existing_ous_second_level = { for ou_path, ou_value in local.existing_ous : ou_path => {
    id = ou_value
    } if length(split("/", ou_path)) == 3
  }

  existing_ous_third_level = { for ou_path, ou_value in local.existing_ous : ou_path => {
    id = ou_value
    } if length(split("/", ou_path)) == 4
  }

  existing_ous_fourth_level = { for ou_path, ou_value in local.existing_ous : ou_path => {
    id = ou_value
    } if length(split("/", ou_path)) == 5
  }

  existing_ous_fifth_level = { for ou_path, ou_value in local.existing_ous : ou_path => {
    id = ou_value
    } if length(split("/", ou_path)) == 6
  }
}

#import the existing organization and OUs
#Commented because we decided to remove the activation of services to web console and we are going to handle only delegations
# import {
#   to = module.org.aws_organizations_organization.this
#   id = local.org_id
# }


import {
  for_each = local.existing_ous_first_level
  to       = module.org.aws_organizations_organizational_unit.first_level[each.key]
  id       = each.value.id
}

import {
  for_each = local.existing_ous_second_level
  to       = module.org.aws_organizations_organizational_unit.second_level[each.key]
  id       = each.value.id
}

import {
  for_each = local.existing_ous_third_level
  to       = module.org.aws_organizations_organizational_unit.third_level[each.key]
  id       = each.value.id
}

import {
  for_each = local.existing_ous_fourth_level
  to       = module.org.aws_organizations_organizational_unit.fourth_level[each.key]
  id       = each.value.id
}

import {
  for_each = local.existing_ous_fifth_level
  to       = module.org.aws_organizations_organizational_unit.fifth_level[each.key]
  id       = each.value.id
}
