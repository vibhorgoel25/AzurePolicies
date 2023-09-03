#This policy set definition refers various policy definitions for diagnostics logs for azure services.
#This policy set also makes use of how to define parameters for policy set itself which can be reused in policy definition reference block.
#Please adjust the code below to meet any values as per your requirement.

# Create the Policy Initiative with all above policies
#
resource "azurerm_policy_set_definition" "diag_to_eh" {
  name                = "diag_to_eh"
  policy_type         = "Custom"
  display_name        = "Deploy Diagnostic Settings to Event Hub"
  management_group_id = data.azurerm_management_group.mg_core.id
  metadata            = <<METADATA
    {
    "category": "Monitoring"
    }
  METADATA

  parameters = <<PARAMETERS
    ${file(
  "${path.module}/definitions/diag_to_eh.params.json",
)}
  PARAMETERS

policy_definition_reference {
  policy_definition_id = azurerm_policy_definition.diag_to_eh_dbforpostgresql.id
  parameter_values     = <<VALUES
  {
    "resourceLocation" : {"value": "[parameters('resourceLocation')]"},
    "profileName"      : {"value": "[parameters('profileName')]"},
    "eventHubName"     : {"value": "[parameters('eventHubName')]"},
    "eventHubRuleId"   : {"value": "[parameters('eventHubRuleId')]"},
    "metricsEnabled"   : {"value": "[parameters('metricsEnabled')]"},
    "logsEnabled"      : {"value": "[parameters('logsEnabled')]"},
    "policyEffect"     : {"value": "[parameters('policyEffectDBForPostgreSQL')]"}
  }
  VALUES
}
policy_definition_reference {
  policy_definition_id = azurerm_policy_definition.diag_to_eh_appgateway.id
  parameter_values     = <<VALUES
  {
    "resourceLocation" : {"value": "[parameters('resourceLocation')]"},
    "profileName"      : {"value": "[parameters('profileName')]"},
    "eventHubName"     : {"value": "[parameters('eventHubName')]"},
    "eventHubRuleId"   : {"value": "[parameters('eventHubRuleId')]"},
    "metricsEnabled"   : {"value": "[parameters('metricsEnabled')]"},
    "logsEnabled"      : {"value": "[parameters('logsEnabled')]"},
    "policyEffect"     : {"value": "[parameters('policyEffectAppGateway')]"}
  }
  VALUES
}
policy_definition_reference {
  policy_definition_id = azurerm_policy_definition.diag_to_eh_keyvault.id
  parameter_values     = <<VALUES
   {
    "profileName"      : {"value": "[parameters('profileName')]"},
    "eventHubName"     : {"value": "[parameters('eventHubName')]"},
    "eventHubRuleId"   : {"value": "[parameters('eventHubRuleId')]"},
    "eventHubLocation" : {"value": "[parameters('resourceLocation')]"},
    "metricsEnabled"   : {"value": "[parameters('metricsEnabled')]"},
    "logsEnabled"      : {"value": "[parameters('logsEnabled')]"},
    "policyEffect"     : {"value": "[parameters('policyEffectKeyVault')]"}
  }
  VALUES
}
policy_definition_reference {
  policy_definition_id = azurerm_policy_definition.diag_to_eh_publicipaddress.id
  parameter_values     = <<VALUES
  {
    "resourceLocation" : {"value": "[parameters('resourceLocation')]"},
    "profileName"      : {"value": "[parameters('profileName')]"},
    "eventHubName"     : {"value": "[parameters('eventHubName')]"},
    "eventHubRuleId"   : {"value": "[parameters('eventHubRuleId')]"},
    "metricsEnabled"   : {"value": "[parameters('metricsEnabled')]"},
    "logsEnabled"      : {"value": "[parameters('logsEnabled')]"},
    "policyEffect"     : {"value": "[parameters('policyEffectPublicIpAddress')]"}
  }
  VALUES
}
policy_definition_reference {
  policy_definition_id = azurerm_policy_definition.diag_to_eh_databricks.id
  parameter_values     = <<VALUES
  {
    "resourceLocation" : {"value": "[parameters('resourceLocation')]"},
    "profileName"      : {"value": "[parameters('profileName')]"},
    "eventHubName"     : {"value": "[parameters('eventHubName')]"},
    "eventHubRuleId"   : {"value": "[parameters('eventHubRuleId')]"},
    "logsEnabled"      : {"value": "[parameters('logsEnabled')]"},
    "policyEffect"     : {"value": "[parameters('policyEffectDatabricks')]"}
  }
  VALUES
}
}
####################################################################
