#Sample terraform policy defintion code using FILE function to refer path to policy defintion file & policy parameter file. 
#Please replace the values as desired in below code.

# Deploys the diagnostic settings for Application Gateway to stream to a regional Event Hub when missing.
#
resource "azurerm_policy_definition" "diag_to_eh_appgateway" {
  name                = "diag_to_eh_appgateway"
  policy_type         = "Custom"
  mode                = "Indexed"
  display_name        = "Deploy Diagnostic Settings for Application Gateway"
  management_group_id = data.azurerm_management_group.mg_core.id
  metadata            = <<METADATA
    {
    "category": "Monitoring"
    }
  METADATA

  parameters = <<PARAMETERS
    ${file(
  "${path.module}/definitions/diag_to_eh_appgateway.params.json",
)}
  PARAMETERS

policy_rule = <<POLICY_RULE
    ${file(
"${path.module}/definitions/diag_to_eh_appgateway.json",
)}
  POLICY_RULE
}
