####################################################################
#
# Enforce SSL for MySQL Servers Policy

resource "azurerm_policy_definition" "deny_mysql_without_ssl" {
  name                = "deny_mysql_without_ssl"
  policy_type         = "Custom"
  mode                = "All"
  display_name        = "Deny creation of MySQL servers without SSL"
  management_group_id = data.azurerm_management_group.mg_core.id

  metadata = <<METADATA
    {
    "category": "SQL"
    }
  METADATA

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
            "equals": "Microsoft.DBforMySQL/servers"
          },
          {
            "field": "Microsoft.DBforMySQL/servers/sslEnforcement",
            "exists": "true"
          },                        
          {  
            "field": "Microsoft.DBforMySQL/servers/sslEnforcement",
            "notEquals": "Enabled"
          }
        ]
      },          
      "then": {
        "effect": "[parameters('policyEffect')]"
      }
    }
POLICY_RULE
}

# Enforce SSL for MySQL Servers Policy
####################################################################
