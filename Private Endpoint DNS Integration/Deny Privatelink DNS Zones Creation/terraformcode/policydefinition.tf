####################################################################
# Policy to deny creation of private DNS zones with the `privatelink` prefix .

resource "azurerm_policy_definition" "deny_privatelink_dns_zone_creation" {
  # ./README.md#deny-privatelink-dns-zone-creation
  name                = "deny_privatelink_dns_zone_creation"
  policy_type         = "Custom"
  mode                = "All"
  display_name        = "Deny creation of private DNS zones with privatelink prefix"
  management_group_id = data.azurerm_management_group.mg_core.id

  parameters = <<PARAMETERS
    {
      "policyEffect": {
        "type": "string",
        "metadata": {
          "description": "The policy effects to use",
          "displayName": "Allowed Effect"
        },
        "allowedValues": [
          "audit",
          "disabled",
          "deny"
        ],
        "defaultValue": "audit"
      }
    }
  PARAMETERS

  policy_rule = <<POLICY_RULE
    {
      "if": {
        "allof":  [
          {
            "field": "type",
            "equals": "Microsoft.Network/privateDnsZones"
          },
          {
            "field": "name",
            "contains": "privatelink."
          },
          {
            "field": "name",
            "notlike": "*.azmk8s.io"
          }                 
        ]
      },          
      "then": {
        "effect": "[parameters('policyEffect')]"
      }
    }
POLICY_RULE
}

# Policy to deny creation of private DNS zones with the `privatelink` prefix .

####################################################################
