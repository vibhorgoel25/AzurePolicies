#Sample terraform policy defintion code using FILE function to refer path to policy defintion file & policy parameter file.
#Please replace the values as desired in below code.

####################################################################
#
# Enforce FTPS Only for Azure App Services

resource "azurerm_policy_definition" "enforce_ftps_appservices" {
  name                = "enforce_ftps_appservices"
  policy_type         = "Custom"
  mode                = "All"
  display_name        = "Enforce FTPS Only for Azure App Services"
  management_group_id = <

  metadata = <<METADATA
    {
    "category": "App Service"
    }
  METADATA

  parameters = <<PARAMETERS
${file(
  "${path.module}/definitions/enforce_ftps_on_appservices.params.json",
)}
  PARAMETERS

policy_rule = <<POLICY_RULE
${file(
"${path.module}/definitions/enforce_ftps_on_appservices.json",
)}
POLICY_RULE
}

# Enforce FTPS Only for Azure App Services
#####################################################################
