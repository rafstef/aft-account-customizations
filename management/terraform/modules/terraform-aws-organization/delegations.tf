# © 2024 Amazon Web Services, Inc. or its affiliates. All Rights Reserved.
# 
# This AWS Content is provided subject to the terms of the AWS Customer Agreement
# available at http://aws.amazon.com/agreement or other written agreement between
# Customer and either Amazon Web Services, Inc. or Amazon Web Services EMEA SARL or both.

resource "aws_organizations_delegated_administrator" "this" {
  for_each = var.delegations
  service_principal = each.key
  account_id        =  each.value
}


# enables RAM sharing with organization
resource "aws_ram_sharing_with_organization" "this" {
  count = var.enable_ram_sharing ? 1 : 0
}

# delegation for read permissions on organization
resource "aws_organizations_resource_policy" "org_delegations" {
  count   = (length(var.org_readonly_accounts) > 0) ? 1 : 0
  content = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "DelegatingNecessaryDescribeListActions",
      "Effect": "Allow",
      "Principal": {
        "AWS": ${jsonencode(var.org_readonly_accounts)}
      },
      "Action": [
        "organizations:DescribeAccount",
        "organizations:DescribeEffectivePolicy",
        "organizations:DescribeOrganization",
        "organizations:DescribeOrganizationalUnit",
        "organizations:DescribePolicy",
        "organizations:ListAccounts",
        "organizations:ListAccountsForParent",
        "organizations:ListAWSServiceAccessForOrganization",
        "organizations:ListChildren",
        "organizations:ListOrganizationalUnitsForParent",
        "organizations:ListParents",
        "organizations:ListPolicies",
        "organizations:ListPoliciesForTarget",
        "organizations:ListRoots",
        "organizations:ListTagsForResource",
        "organizations:ListTargetsForPolicy"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}
