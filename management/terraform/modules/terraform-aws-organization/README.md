# terraform-aws-organization

This modules manages Organizational Units in AWS Organizations, SCPs, Tag Policies, Control Tower Controls\*.

Moreover, it registers newly created OUs in Control Tower (see module: [modules/control-tower-registration](modules/control-tower-registration/README.md))

Users can pass Organizations hierarchy with the variable `organizational_units`, see examples.

SCP and Tag policies are referenced as files in the filesystem, prepend each path with `${path.root}`, so that terraform can correctly handle the path.

Users can also organization service delegations passing the name of the services into the variable `delegations`, enable RAM sharing with `enable_ram_sharing` and delegate read-only access of the Organization to other accounts, using `org_readonly_accounts`

**\*** as of now, Control Tower registration happens asynchronously, so before adding Control Tower Controls you need to wait that the OU has been onboarded after the first run, you must check it from the AWS Console that the OU is marked as "registered".

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.7.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ct_registration"></a> [ct\_registration](#module\_ct\_registration) | ./modules/control-tower-registration | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_controltower_control.ct_control_fifth_level](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/controltower_control) | resource |
| [aws_controltower_control.ct_control_first_level](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/controltower_control) | resource |
| [aws_controltower_control.ct_control_fourth_level](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/controltower_control) | resource |
| [aws_controltower_control.ct_control_second_level](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/controltower_control) | resource |
| [aws_controltower_control.ct_control_third_level](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/controltower_control) | resource |
| [aws_organizations_delegated_administrator.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_delegated_administrator) | resource |
| [aws_organizations_organizational_unit.fifth_level](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_organizational_unit) | resource |
| [aws_organizations_organizational_unit.first_level](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_organizational_unit) | resource |
| [aws_organizations_organizational_unit.fourth_level](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_organizational_unit) | resource |
| [aws_organizations_organizational_unit.second_level](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_organizational_unit) | resource |
| [aws_organizations_organizational_unit.third_level](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_organizational_unit) | resource |
| [aws_organizations_policy.scps](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_policy) | resource |
| [aws_organizations_policy.tag](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_policy) | resource |
| [aws_organizations_policy_attachment.scp_fifth_level](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_policy_attachment) | resource |
| [aws_organizations_policy_attachment.scp_first_level](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_policy_attachment) | resource |
| [aws_organizations_policy_attachment.scp_fourth_level](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_policy_attachment) | resource |
| [aws_organizations_policy_attachment.scp_second_level](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_policy_attachment) | resource |
| [aws_organizations_policy_attachment.scp_third_level](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_policy_attachment) | resource |
| [aws_organizations_policy_attachment.tag_policy_fifth_level](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_policy_attachment) | resource |
| [aws_organizations_policy_attachment.tag_policy_first_level](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_policy_attachment) | resource |
| [aws_organizations_policy_attachment.tag_policy_fourth_level](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_policy_attachment) | resource |
| [aws_organizations_policy_attachment.tag_policy_second_level](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_policy_attachment) | resource |
| [aws_organizations_policy_attachment.tag_policy_third_level](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_policy_attachment) | resource |
| [aws_organizations_resource_policy.org_delegations](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_resource_policy) | resource |
| [aws_ram_sharing_with_organization.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_sharing_with_organization) | resource |
| [aws_organizations_organization.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_delegations"></a> [delegations](#input\_delegations) | List of delegations, specify the service as key and the account id | `map(string)` | `{}` | no |
| <a name="input_enable_ram_sharing"></a> [enable\_ram\_sharing](#input\_enable\_ram\_sharing) | Enable RAM sharing | `bool` | `true` | no |
| <a name="input_org_readonly_accounts"></a> [org\_readonly\_accounts](#input\_org\_readonly\_accounts) | List of accounts that are granted read access to AWS Organizations | `list(string)` | `[]` | no |
| <a name="input_organizational_units"></a> [organizational\_units](#input\_organizational\_units) | Hierarchy of OUs of the Organization. You must define each node of tree. | <pre>map(object({<br>    scp         = optional(list(string), [])<br>    tag         = optional(list(string), [])<br>    ct_register = optional(bool, true)<br>    ct_control  = optional(list(string), [])<br>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_organization_structure"></a> [organization\_structure](#output\_organization\_structure) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->