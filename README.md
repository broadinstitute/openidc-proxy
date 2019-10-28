# openidc-proxy

[![Docker Hub](https://img.shields.io/docker/pulls/broadinstitute/openidc-proxy.svg)](https://hub.docker.com/r/broadinstitute/openidc-proxy/)
[![Docker Hub](https://img.shields.io/docker/build/broadinstitute/openidc-proxy.svg)](https://hub.docker.com/r/broadinstitute/openidc-proxy/)
[![Docker Repository on Quay](https://quay.io/repository/broadinstitute/openidc-proxy/status "Docker Repository on Quay")](https://quay.io/repository/broadinstitute/openidc-proxy)

This container images extends [OpenIDC BaseImage][1] and adds several features:

* Adds the authz_dbd module to Apache
* Adds a new `site.conf` config file
* Adds the following configurable environment variables to use the extended functionality of the container image:
  * ALLOW_HEADERS3: The CORS headers to allow for *PROXY_PATH3*.  Default:  None
  * ALLOW_METHODS3: The CORS methods to allow for *PROXY_PATH3*.  Default:  None
  * AUTH_REQUIRE3: An OIDC claim to restrict access on *PROXY_PATH3*.  Default: __Require valid-user__
  * AUTH_TYPE3: The AuthType to use for *PROXY_PATH3*.  Default: __AuthType oauth20__
  * ENABLE_STACKDRIVER: Set to *yes* to enable Stackdriver Virtual Host. Default: None
  * PROXY_PATH3: The Apache `Location` to configure with OAuth2.0 authentication, which will require a valid Google token to access.  Default: __/register__

[1]: https://github.com/broadinstitute/openidc-baseimage "OpenIDC BaseImage"
