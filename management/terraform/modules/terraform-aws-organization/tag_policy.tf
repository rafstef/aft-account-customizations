# © 2024 Amazon Web Services, Inc. or its affiliates. All Rights Reserved.
# 
# This AWS Content is provided subject to the terms of the AWS Customer Agreement
# available at http://aws.amazon.com/agreement or other written agreement between
# Customer and either Amazon Web Services, Inc. or Amazon Web Services EMEA SARL or both.

resource "aws_organizations_policy" "tag" {
  for_each = { for t in local.tag_policies : t => t }
  name     = trimsuffix(basename(each.value), ".json")
  content  = jsonencode(jsondecode(file(each.value)))
  type     = "TAG_POLICY"
}

resource "aws_organizations_policy_attachment" "tag_policy_first_level" {
  for_each  = local.tag_per_ou_first_level
  policy_id = aws_organizations_policy.tag[each.value.tag].id
  target_id = aws_organizations_organizational_unit.first_level[each.value.ou].id
}

resource "aws_organizations_policy_attachment" "tag_policy_second_level" {
  for_each  = local.tag_per_ou_second_level
  policy_id = aws_organizations_policy.tag[each.value.tag].id
  target_id = aws_organizations_organizational_unit.second_level[each.value.ou].id
}

resource "aws_organizations_policy_attachment" "tag_policy_third_level" {
  for_each  = local.tag_per_ou_third_level
  policy_id = aws_organizations_policy.tag[each.value.tag].id
  target_id = aws_organizations_organizational_unit.third_level[each.value.ou].id
}

resource "aws_organizations_policy_attachment" "tag_policy_fourth_level" {
  for_each  = local.tag_per_ou_fourth_level
  policy_id = aws_organizations_policy.tag[each.value.tag].id
  target_id = aws_organizations_organizational_unit.fourth_level[each.value.ou].id
}

resource "aws_organizations_policy_attachment" "tag_policy_fifth_level" {
  for_each  = local.tag_per_ou_fifth_level
  policy_id = aws_organizations_policy.tag[each.value.tag].id
  target_id = aws_organizations_organizational_unit.fifth_level[each.value.ou].id
}
