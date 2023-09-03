#Sample terraform policy defintion code using FILE function to refer path to policy defintion file & policy parameter file.
#Please replace the values as desired in below code.

####################################################################
#
# Policy to Deny creation of resources if certain tags are not set
# For future use see ./README.md# .

resource "azurerm_policy_definition" "deny_resource_creation" {
  name                = "deny_resource_creation"
  policy_type         = "Custom"
  mode                = "Indexed"
  display_name        = "Deny Resource Creation if Mandatory Tags Missing"
  management_group_id = data.azurerm_management_group.mg_core.id
  description         = "Deny Resource Creation if Mandatory Tags Missing"

  metadata = <<METADATA
    {
    "category": "Tags"
    }
  METADATA

  parameters = <<PARAMETERS
    ${file(
  "${path.module}/definitions/deny_resource_creation.params.json",
)}
  PARAMETERS

policy_rule = <<POLICY_RULE
   ${file(
"${path.module}/definitions/deny_resource_creation.json",
)}
  POLICY_RULE
}
# Policy to Deny Resource Creation if Mandatory Tags Missing
####################################################################
