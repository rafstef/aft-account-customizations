# © 2024 Amazon Web Services, Inc. or its affiliates. All Rights Reserved.
# 
# This AWS Content is provided subject to the terms of the AWS Customer Agreement
# available at http://aws.amazon.com/agreement or other written agreement between
# Customer and either Amazon Web Services, Inc. or Amazon Web Services EMEA SARL or both.

output "organization_structure" {
  value = {
    for k, v in merge(
      aws_organizations_organizational_unit.first_level,
      aws_organizations_organizational_unit.second_level,
      aws_organizations_organizational_unit.third_level,
      aws_organizations_organizational_unit.fourth_level,
      aws_organizations_organizational_unit.fifth_level
      ) : k => {
      id  = v.id
      arn = v.arn
    }
  }
}
