# Adding a sample of policy definition as well for this policy as it needs creation of additional resources like UAMI & RBAC assignments for the same.
# We also used locals in terraform here to fetch the resource id as we can't use output if we need that to be reference in same module call.
# Please modify the below code as per your need:

####################################################################

variable "location" {
  type        = string
  description = "Location of the Policy assignments"
}

variable "policyeffect_mysql_flexibleserver_cmk" {
  type        = string
  description = "Policy mode to use for"
  default     = "auditifnotexists"
}

variable "mysql_cmk_key_identifier" {
  type        = string
  description = "Key identifier to use for MySQL Flexible Servers CMK encryption"
  default     = ""
}

data "azurerm_policy_definition" "encrypt_mysql_flexibleserver_cmk" {
  display_name = "Encrypt MySQL Flexible Servers with CMK"
}

data "azurerm_resource_group" "shared" {
  name = "<Enter RG Name where you want to place the UAMI being created>"
}

data "azurerm_subscription" "current" {}

resource "azurerm_user_assigned_identity" "mysqlflexibleserver_uami" {
  location            = data.azurerm_resource_group.shared.location
  name                = "uami-mysql-flexibleserver-cmk"
  resource_group_name = data.azurerm_resource_group.shared.name
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

locals {
  uamiId   = azurerm_user_assigned_identity.mysqlflexibleserver_uami.id
}

resource "azurerm_subscription_policy_assignment" "encrypt_mysql_flexibleserver_cmk" {
  name                 = "encrypt_mysql_flexibleserver_cmk"
  subscription_id      = data.azurerm_subscription.current.id
  policy_definition_id = data.azurerm_policy_definition.encrypt_mysql_flexibleserver_cmk.id
  description          = "Encrypt MySQL Flexible Servers with CMK"
  display_name         = "Encrypt MySQL Flexible Servers with CMK"

  identity {
    type = "UserAssigned"
    identity_ids = [
      azurerm_user_assigned_identity.mysqlflexibleserver_uami.id
    ]
  }

  location = var.location

  metadata = <<METADATA
    {
    "category": "SQL"
    }
METADATA

  parameters = <<PARAMETERS
{
  "UAMIId": {
    "value": "${local.uamiId}"
  }, 
  "KeyVaultKey": {
    "value": "${var.mysql_cmk_key_identifier}"
  },
  "resourceLocation": {
    "value": "${var.location}"
  },  
  "policyEffect": {
    "value": "${var.policyeffect_mysql_flexibleserver_cmk}"
  }
}
PARAMETERS
}

resource "azurerm_role_assignment" "uami_contributor" {
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.mysqlflexibleserver_uami.principal_id
}

resource "azurerm_role_assignment" "uami_to_keyvault" {
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Key Vault Crypto Service Encryption User"
  principal_id         = azurerm_user_assigned_identity.mysqlflexibleserver_uami.principal_id
}
####################################################################
