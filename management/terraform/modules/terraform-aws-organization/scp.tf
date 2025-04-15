# © 2024 Amazon Web Services, Inc. or its affiliates. All Rights Reserved.
# 
# This AWS Content is provided subject to the terms of the AWS Customer Agreement
# available at http://aws.amazon.com/agreement or other written agreement between
# Customer and either Amazon Web Services, Inc. or Amazon Web Services EMEA SARL or both.

resource "aws_organizations_policy" "scps" {
  for_each = { for s in local.scps : s => s }
  name     = trimsuffix(basename(each.value), ".json")
  content  = jsonencode(jsondecode(file(each.value)))
}


resource "aws_organizations_policy_attachment" "scp_first_level" {
  for_each  = local.scp_per_ou_first_level
  policy_id = aws_organizations_policy.scps[each.value.scp].id
  target_id = aws_organizations_organizational_unit.first_level[each.value.ou].id
}

resource "aws_organizations_policy_attachment" "scp_second_level" {
  for_each  = local.scp_per_ou_second_level
  policy_id = aws_organizations_policy.scps[each.value.scp].id
  target_id = aws_organizations_organizational_unit.second_level[each.value.ou].id
}

resource "aws_organizations_policy_attachment" "scp_third_level" {
  for_each  = local.scp_per_ou_third_level
  policy_id = aws_organizations_policy.scps[each.value.scp].id
  target_id = aws_organizations_organizational_unit.third_level[each.value.ou].id
}

resource "aws_organizations_policy_attachment" "scp_fourth_level" {
  for_each  = local.scp_per_ou_fourth_level
  policy_id = aws_organizations_policy.scps[each.value.scp].id
  target_id = aws_organizations_organizational_unit.fourth_level[each.value.ou].id
}

resource "aws_organizations_policy_attachment" "scp_fifth_level" {
  for_each  = local.scp_per_ou_fifth_level
  policy_id = aws_organizations_policy.scps[each.value.scp].id
  target_id = aws_organizations_organizational_unit.fifth_level[each.value.ou].id
}

