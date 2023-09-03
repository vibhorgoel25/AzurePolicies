#Sample terraform policy defintion code using FILE function to refer path to policy defintion file & policy parameter file.
#Please replace the values as desired in below code.

####################################################################
#
# Deploy private DNS zone config for KeyVault service

resource "azurerm_policy_definition" "deploy_private_dns_zone_config_vault" {
  name                = "deploy_private_dns_zone_config_vault"
  policy_type         = "Custom"
  mode                = "All"
  display_name        = "Deploy Private DNS zone Configuration for KeyVault service"
  management_group_id = data.azurerm_management_group.mg_core.id

  metadata = <<METADATA
    {
    "category": "Storage"
    }
  METADATA

  parameters = <<PARAMETERS
${file(
  "${path.module}/definitions/dns_config.params.json",
)}
  PARAMETERS

policy_rule = <<POLICY_RULE
${file(
"${path.module}/definitions/dns_config_vault.json",
)}
POLICY_RULE
}

# Deploy private DNS zone config for KeyVault service
####################################################################
