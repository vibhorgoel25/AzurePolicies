#Sample terraform policy set defintion code referencing various policy defintions under it. 
#Please replace the values as desired in below code.

####################################################################
# Initiative definition for PrivateLink DNS Configuration Deployment.

resource "azurerm_policy_set_definition" "privatelink_dns_config" {
  name                = "privatelink_dns_config"
  description         = "Policy Initiative to deploy privatelink DNS configuration"
  display_name        = "PrivateLink DNS Configuration Deployment"
  management_group_id = data.azurerm_management_group.mg_core.id
  policy_type         = "Custom"
  parameters          = <<PARAMETERS
    {
      "policysetEffect": {
        "type": "string",
        "metadata": {
          "description": "The policy effects to use",
          "displayName": "Allowed PolicySet Effect"
        },
        "allowedValues": [
          "AuditIfNotExists",
          "disabled",
          "DeployIfNotExists"
        ],
        "defaultValue": "AuditIfNotExists"
      },
      "privatelink_dns_rg": {
        "type": "string",
        "metadata": {
          "description": "Path to the resource group where privatelink DNS zones exist"
        }
      }
    }
  PARAMETERS

  policy_definition_reference {
    policy_definition_id = resource.azurerm_policy_definition.deploy_private_dns_zone_config_blob.id
    parameter_values     = <<VALUE
    {
      "privateDnsZoneId": {"value": "[concat(parameters('privatelink_dns_rg'),'/providers/Microsoft.Network/privateDnsZones/privatelink.blob.core.windows.net')]"},
      "policyEffect"     : {"value": "[parameters('policysetEffect')]"}
    }
    VALUE
  }

  policy_definition_reference {
    policy_definition_id = resource.azurerm_policy_definition.deploy_private_dns_zone_config_vault.id
    parameter_values     = <<VALUE
    {
      "privateDnsZoneId": {"value": "[concat(parameters('privatelink_dns_rg'),'/providers/Microsoft.Network/privateDnsZones/privatelink.vaultcore.azure.net')]"},
      "policyEffect"     : {"value": "[parameters('policysetEffect')]"}
    }
    VALUE
  }
}

####################################################################
