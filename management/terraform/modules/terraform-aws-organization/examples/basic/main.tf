# © 2024 Amazon Web Services, Inc. or its affiliates. All Rights Reserved.
# 
# This AWS Content is provided subject to the terms of the AWS Customer Agreement
# available at http://aws.amazon.com/agreement or other written agreement between
# Customer and either Amazon Web Services, Inc. or Amazon Web Services EMEA SARL or both.

terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {}

provider "aws" {
  alias  = "ct_management"
  region = "us-east-1"
}

module "org" {
  source = "./../.."

  providers = {
    aws.ct_management = aws.ct_management
  }

  organizational_units = {
    "/Suspended" = {
      scp = [
        "${path.root}/policies/scp/scp_deny_all.json"
      ]
      ct_register = false
    }
    "/Infrastructure" = {
      ct_control = [
        "AWS-GR_AUDIT_BUCKET_LOGGING_ENABLED",
        "AWS-GR_AUDIT_BUCKET_RETENTION_POLICY"
      ]
    }
    "/Workloads"             = {}
    "/Workloads/development" = {}
    "/Workloads/qa"          = {}
    "/Workloads/production"  = {}
  }
}
