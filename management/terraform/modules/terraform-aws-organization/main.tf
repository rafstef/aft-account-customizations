# © 2024 Amazon Web Services, Inc. or its affiliates. All Rights Reserved.
# 
# This AWS Content is provided subject to the terms of the AWS Customer Agreement
# available at http://aws.amazon.com/agreement or other written agreement between
# Customer and either Amazon Web Services, Inc. or Amazon Web Services EMEA SARL or both.

# this module installs lambda and components needed to CT enrollment of OUs
# waiting for a proper implementation in the terraform provider
module "ct_registration" {
  source = "./modules/control-tower-registration"

  providers = {
    aws = aws.ct_management
  }
  ct_main_region = data.aws_region.current.name
}
