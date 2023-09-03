#Sample terraform policy defintion code using FILE function to refer path to policy defintion file & policy parameter file. 
#Please replace the values as desired in below code.

####################################################################
#
# Enforce HTTPS Only for Azure App Services

resource "azurerm_policy_definition" "enforce_https_appservices" {
  name                = "enforce_https_appservices"
  policy_type         = "Custom"
  mode                = "All"
  display_name        = "Enforce HTTPS Only for Azure App Services"
  management_group_id = data.azurerm_management_group.mg_core.id

  metadata = <<METADATA
    {
    "category": "App Service"
    }
  METADATA

  parameters = <<PARAMETERS
${file(
  "${path.module}/definitions/enforce_https_on_appservices.params.json",
)}
  PARAMETERS

policy_rule = <<POLICY_RULE
${file(
"${path.module}/definitions/enforce_https_on_appservices.json",
)}
POLICY_RULE
}

# Enforce HTTPS Only for Azure App Services
#####################################################################
