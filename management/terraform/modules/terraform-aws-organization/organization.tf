# © 2024 Amazon Web Services, Inc. or its affiliates. All Rights Reserved.
# 
# This AWS Content is provided subject to the terms of the AWS Customer Agreement
# available at http://aws.amazon.com/agreement or other written agreement between
# Customer and either Amazon Web Services, Inc. or Amazon Web Services EMEA SARL or both.
resource "aws_organizations_organizational_unit" "first_level" {
  for_each  = local.ous_first_level
  name      = each.value.name
  parent_id = data.aws_organizations_organization.this.roots[0].id

  tags = {
    "ct_register" = each.value.ct_register ? "true" : "false"
  }

  depends_on = [module.ct_registration]
}

resource "aws_organizations_organizational_unit" "second_level" {
  for_each  = local.ous_second_level
  name      = each.value.name
  parent_id = aws_organizations_organizational_unit.first_level[each.value.parent_path].id

  tags = {
    "ct_register" = each.value.ct_register ? "true" : "false"
  }
}

resource "aws_organizations_organizational_unit" "third_level" {
  for_each  = local.ous_third_level
  name      = each.value.name
  parent_id = aws_organizations_organizational_unit.second_level[each.value.parent_path].id

  tags = {
    "ct_register" = each.value.ct_register ? "true" : "false"
  }
}

resource "aws_organizations_organizational_unit" "fourth_level" {
  for_each  = local.ous_fourth_level
  name      = each.value.name
  parent_id = aws_organizations_organizational_unit.third_level[each.value.parent_path].id

  tags = {
    "ct_register" = each.value.ct_register ? "true" : "false"
  }
}

resource "aws_organizations_organizational_unit" "fifth_level" {
  for_each  = local.ous_fifth_level
  name      = each.value.name
  parent_id = aws_organizations_organizational_unit.fourth_level[each.value.parent_path].id

  tags = {
    "ct_register" = each.value.ct_register ? "true" : "false"
  }
}

