#Sample terraform policy defintion code using FILE function to refer path to policy defintion file & policy parameter file. 
#Please replace the values as desired in below code.

####################################################################
#
# Policy to Encrypt MySQL Flexible Servers with CMK

resource "azurerm_policy_definition" "mysql_flexibleserver_cmk" {
  name                = "mysql_flexibleserver_cmk"
  policy_type         = "Custom"
  mode                = "Indexed"
  display_name        = "Encrypt MySQL Flexible Servers with CMK"
  management_group_id = data.azurerm_management_group.mg_core.id
  description         = "Encrypt MySQL Flexible Servers with CMK"

  metadata = <<METADATA
    {
    "category": "SQL"
    }
  METADATA

  parameters = <<PARAMETERS
    ${file(
  "${path.module}/definitions/encrypt_mysql_flexibleserver_cmk.params.json",
)}
  PARAMETERS

policy_rule = <<POLICY_RULE
   ${file(
"${path.module}/definitions/encrypt_mysql_flexibleserver_cmk.json",
)}
  POLICY_RULE
}
# Policy to Encrypt MySQL Flexible Servers with CMK
####################################################################
