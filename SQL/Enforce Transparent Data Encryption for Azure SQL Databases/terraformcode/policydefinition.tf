#Sample terraform policy defintion code using FILE function to refer path to policy defintion file & policy parameter file.
#Please replace the values as desired in below code.

####################################################################
#
# Enforce transparent data encryption for SQL Databases under Azure SQL server

resource "azurerm_policy_definition" "tde_sql_databases" {
  name                = "tde_sql_databases"
  policy_type         = "Custom"
  mode                = "All"
  display_name        = "Enforce transparent data encryption for SQL Databases under Azure SQL server"
  management_group_id = data.azurerm_management_group.mg_core.id

  metadata = <<METADATA
    {
    "category": "SQL"
    }
  METADATA

  parameters = <<PARAMETERS
${file(
  "${path.module}/definitions/tde_sql_databases.params.json",
)}
  PARAMETERS

policy_rule = <<POLICY_RULE
${file(
"${path.module}/definitions/tde_sql_databases.json",
)}
POLICY_RULE
}

# Enforce transparent data encryption for SQL Databases under Azure SQL server
#####################################################################
