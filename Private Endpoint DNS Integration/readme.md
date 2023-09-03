This section contains various policies related to enterprise scale integration of DNS configuration for Private Endpoint for various azure services.
It's advisable to define a policy set to implement such all such set of policies whcih integrates DNS configuration inside a private endpoint.

This section also includes a DENY policy to deny any creation of privatelink related DNS zones as ideally one such zone should be existing in whole company & every one should use such zone from centrally accessible subscription where it's deployed instead of creating his own privatelink DNS zone.
