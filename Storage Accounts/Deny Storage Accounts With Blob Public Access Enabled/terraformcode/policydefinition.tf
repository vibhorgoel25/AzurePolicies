####################################################################
# Deny policy for Storage Accounts with Blob public access enabled


resource "azurerm_policy_definition" "deny_stg_accounts_with_blob_public_access_enabled" {
  name                = "deny_stg_accounts_with_blob_public_access_enabled"
  policy_type         = "Custom"
  mode                = "All"
  display_name        = "Deny Storage Accounts with Blob public access enabled"
  management_group_id = data.azurerm_management_group.mg_core.id

  metadata = <<METADATA
    {
    "category": "Storage"
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
            "equals": "Microsoft.Storage/storageAccounts"
          },
          {
            "field": "Microsoft.Storage/storageAccounts/allowBlobPublicAccess",
            "exists": "true"
          },
          {
            "field": "Microsoft.Storage/storageAccounts/allowBlobPublicAccess",
            "equals": "true"
          }      
        ]
      },          
      "then": {
        "effect": "[parameters('policyEffect')]"
      }
    }
POLICY_RULE
}

####################################################################
