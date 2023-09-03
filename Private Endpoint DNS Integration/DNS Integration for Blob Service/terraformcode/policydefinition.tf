#Sample terraform policy defintion code using FILE function to refer path to policy defintion file & policy parameter file. 
#Please replace the values as desired in below code.

###################################################################
#
# Deploy private DNS zone config for Azure Blob service

resource "azurerm_policy_definition" "deploy_private_dns_zone_config_blob" {
  name                = "deploy_private_dns_zone_config_blob"
  policy_type         = "Custom"
  mode                = "All"
  display_name        = "Deploy Private DNS zone Configuration for Azure Blob service"
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
"${path.module}/definitions/dns_config_blob.json",
)}
POLICY_RULE
}

# Deploy private DNS zone config for Azure Blob service
####################################################################
