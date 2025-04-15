# © 2024 Amazon Web Services, Inc. or its affiliates. All Rights Reserved.
# 
# This AWS Content is provided subject to the terms of the AWS Customer Agreement
# available at http://aws.amazon.com/agreement or other written agreement between
# Customer and either Amazon Web Services, Inc. or Amazon Web Services EMEA SARL or both.

resource "aws_controltower_control" "ct_control_first_level" {
  for_each = local.ct_control_per_ou_first_level
  control_identifier = "arn:aws:controlcatalog:::control/${local.ct_control_def[each.value.ct_control]}"
  target_identifier  = aws_organizations_organizational_unit.first_level[each.value.ou].arn
}

resource "aws_controltower_control" "ct_control_second_level" {
  for_each = local.ct_control_per_ou_second_level
  control_identifier = "arn:aws:controlcatalog:::control/${local.ct_control_def[each.value.ct_control]}"
  target_identifier  = aws_organizations_organizational_unit.second_level[each.value.ou].arn
}

resource "aws_controltower_control" "ct_control_third_level" {
  for_each = local.ct_control_per_ou_third_level
  control_identifier = "arn:aws:controlcatalog:::control/${local.ct_control_def[each.value.ct_control]}"
  target_identifier  = aws_organizations_organizational_unit.third_level[each.value.ou].arn
}

resource "aws_controltower_control" "ct_control_fourth_level" {
  for_each = local.ct_control_per_ou_fourth_level
  control_identifier = "arn:aws:controlcatalog:::control/${local.ct_control_def[each.value.ct_control]}"
  target_identifier  = aws_organizations_organizational_unit.fourth_level[each.value.ou].arn
}

resource "aws_controltower_control" "ct_control_fifth_level" {
  for_each = local.ct_control_per_ou_fifth_level
  control_identifier = "arn:aws:controlcatalog:::control/${local.ct_control_def[each.value.ct_control]}"
  target_identifier  = aws_organizations_organizational_unit.fifth_level[each.value.ou].arn
}
