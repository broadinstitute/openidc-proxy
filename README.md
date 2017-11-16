openidc-proxy
=================

This container images extends [OpenIDC BaseImage][1] and adds several features:

* Adds the authnz_ldap module to Apache
* Adds a new `site.conf` config file
* Adds the following configurable environment variables to use the extended functionality of the container image:
  * ALLOW_HEADERS3: The CORS headers to allow for *PROXY_PATH3*.  Default:  None
  * ALLOW_METHODS3: The CORS methods to allow for *PROXY_PATH3*.  Default:  None
  * AUTH_REQUIRE3: An OIDC claim to restrict access on *PROXY_PATH3*.  Default: __Require valid-user__
  * AUTH_TYPE3: The AuthType to use for *PROXY_PATH3*.  Default: __AuthType oauth20__
  * AUTH_LDAP_BIND_DN: The AuthLDAPBindDN to use for *PROXY_PATH*.  Default: None
  * AUTH_LDAP_BIND_DN2: The AuthLDAPBindDN to use for *PROXY_PATH2*.  Default: None
  * AUTH_LDAP_BIND_DN3: The AuthLDAPBindDN to use for *PROXY_PATH3*.  Default: None
  * AUTH_LDAP_BIND_PASSWORD: The AuthLDAPBindPassword to use for *PROXY_PATH*.  Default: None
  * AUTH_LDAP_BIND_PASSWORD2: The AuthLDAPBindPassword to use for *PROXY_PATH2*.  Default: None
  * AUTH_LDAP_BIND_PASSWORD3: The AuthLDAPBindPassword to use for *PROXY_PATH3*.  Default: None
  * AUTH_LDAP_GROUP_ATTR: The AuthLDAPGroupAttribute to use for *PROXY_PATH*.  Default: None
  * AUTH_LDAP_GROUP_ATTR2: The AuthLDAPGroupAttribute to use for *PROXY_PATH2*.  Default: None
  * AUTH_LDAP_GROUP_ATTR3: The AuthLDAPGroupAttribute to use for *PROXY_PATH3*.  Default: None
  * AUTH_LDAP_URL: The AuthLDAPURL to use for *PROXY_PATH*.  Default: None
  * AUTH_LDAP_URL2: The AuthLDAPURL to use for *PROXY_PATH2*.  Default: None
  * AUTH_LDAP_URL3: The AuthLDAPURL to use for *PROXY_PATH3*.  Default: None
  * ENABLE_STACKDRIVER: Set to *yes* to enable Stackdriver Virtual Host. Default: None
  * ENABLE_WEBSOCKET: Set to *yes* to enable websocket/wstunnel module. Default: None
  * ENABLE_REMOTEIP: Set to *yes* to enable remoteip module. Default: None
  * ENABLE_MODSECURITY: Set to *yes* to enable Mod_security capability Virtual Host. Default: None
  * DISABLE_SSLPROXY_CHECKS: Set to *yes* to disable all of the folloing SSL Proxy checks:
    * PROXY_VERIFY
    * PROXY_CHECK_PEERCN
    * PROXY_CHECK_PEERNAME
    * PROXY_CHECK_PEEREXPIRE
    * NOTE: the above can individually be set via environment variables
  * LDAP_CACHE_TTL: The LDAP cache timeout.  Default: __60__
  * PROXY_PATH3: The Apache `Location` to configure with OAuth2.0 authentication, which will require a valid Google token to access.  Default: __/register__

[1]: https://github.com/broadinstitute/openidc-baseimage "OpenIDC BaseImage"
