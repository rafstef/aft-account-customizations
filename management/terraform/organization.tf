module "org" {
  source = "./modules/terraform-aws-organization"
  providers = {
    aws.ct_management = aws.ct_management
  }

  organizational_units = {
    "/Suspended" = {
      # scp = ["./policies/scp/scp_deny_all.json"]
    }
    "/Aft" = {
      scp        = []
      ct_control = []
    }
    "/Foundational" = {
      # scp        = []
      # ct_control = ["AWS-GR_RESTRICT_ROOT_USER", "AWS-GR_RESTRICT_ROOT_USER_ACCESS_KEYS"]
    }
    "/Sandbox" = {
      # scp        = []
      # ct_control = ["AWS-GR_RESTRICT_ROOT_USER", "AWS-GR_RESTRICT_ROOT_USER_ACCESS_KEYS"]
    }
    "/Security" = {
      # scp        = []
      # ct_control = ["AWS-GR_RESTRICT_ROOT_USER", "AWS-GR_RESTRICT_ROOT_USER_ACCESS_KEYS"]
    }
    "/Policy-staging" = {
      # scp        = []
      # ct_control = ["AWS-GR_RESTRICT_ROOT_USER", "AWS-GR_RESTRICT_ROOT_USER_ACCESS_KEYS"]
    }
    "/Workload" = {
      # scp        = []
      # ct_control = ["AWS-GR_RESTRICT_ROOT_USER", "AWS-GR_RESTRICT_ROOT_USER_ACCESS_KEYS"]
    }
    "/Workload/Workload-dev"       = {}
    "/Workload/Workload-tst"       = {}
    "/Workload/Workload-prd"       = {}
    "/Foundational/Infrastructure" = {}
    "/Foundational/Security"       = {}
  }

  enable_ram_sharing = true

  org_readonly_accounts = [
    "123456789012" # aft deployment account ID
  ]

  # Delegations here contains all the services that can be managed through the general purpose resource aws_organizations_delegated_administrator and don't have a service-specific resource
  # All the services that can be delegated with a service-specific resource must be defined in the non_standard_delegations.tf file
  # To know which services can be delegated with a service-specific resource filter by 'admin' word here https://registry.terraform.io/providers/hashicorp/aws/latest/docs. If there is a delegated admin resource skip this dict.
  # Examples: aws_guardduty_organization_admin_account, aws_securityhub_organization_admin_account
  # NOTE: BEFORE ENABLING ANY KIND OF DELEGATION, ENABLE THE SPECIFIC SERVICE IN  AWS ORGANIZATIONS  (INSIDE MANAGEMENT ACCOUNT). YOU CAN USE THIS LINK https://us-east-1.console.aws.amazon.com/organizations/v2/home/services
  delegations = {
    # "sso.amazonaws.com"    = "522814722499"
  }
}
