This policy enabled CMK encryption for MySQL Flexible servers.
This policy has below requirements before you implement it:

RSA keys 2096 in size should be present in key vault

A user assigned managed identity should be created with Key Vault Crypto Service Encryption User permissions assigned to the key vault being used for CMK encryption.

The user assigned managed identity should also have permissions at Database level to modify it's encryption settings i.e a contributor role.
