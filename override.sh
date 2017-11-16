#!/bin/sh

# I'm an override file.  Put things in here to override the openidc-baseimage
# defaults or add more settings of your own.
#
# Note: This script will be executed *after* the main `run.sh` script, but
# *before* Apache itself is run.

# set ALLOW_HEADERS3
if [ -z "$ALLOW_HEADERS3" ] ; then
    export ALLOW_HEADERS3=
fi

# update ALLOW_METHODS3
if [ -z "$ALLOW_METHODS3" ] ; then
    export ALLOW_METHODS3=
fi

# update AUTH_REQUIRE3
if [ -z "$AUTH_REQUIRE3" ] ; then
    export AUTH_REQUIRE3='Require valid-user'
elif [ "$AUTH_REQUIRE3" = '(none)' ]; then
    export AUTH_REQUIRE3=
fi

# update AUTH_TYPE3
if [ -z "$AUTH_TYPE3" ] ; then
    export AUTH_TYPE3='AuthType oauth20'
fi

# update AUTH_LDAP_BIND_DN
if [ -z "$AUTH_LDAP_BIND_DN" ] ; then
    export AUTH_LDAP_BIND_DN=
fi

# update AUTH_LDAP_BIND_DN2
if [ -z "$AUTH_LDAP_BIND_DN2" ] ; then
    export AUTH_LDAP_BIND_DN2=
fi

# update AUTH_LDAP_BIND_DN3
if [ -z "$AUTH_LDAP_BIND_DN3" ] ; then
    export AUTH_LDAP_BIND_DN3=
fi

# update AUTH_LDAP_BIND_PASSWORD
if [ -z "$AUTH_LDAP_BIND_PASSWORD" ] ; then
    export AUTH_LDAP_BIND_PASSWORD=
fi

# update AUTH_LDAP_BIND_PASSWORD2
if [ -z "$AUTH_LDAP_BIND_PASSWORD2" ] ; then
    export AUTH_LDAP_BIND_PASSWORD2=
fi

# update AUTH_LDAP_BIND_PASSWORD3
if [ -z "$AUTH_LDAP_BIND_PASSWORD3" ] ; then
    export AUTH_LDAP_BIND_PASSWORD3=
fi

# update AUTH_LDAP_URL
if [ -z "$AUTH_LDAP_URL" ] ; then
    export AUTH_LDAP_URL=
fi

# update AUTH_LDAP_URL2
if [ -z "$AUTH_LDAP_URL2" ] ; then
    export AUTH_LDAP_URL2=
fi

# update AUTH_LDAP_URL3
if [ -z "$AUTH_LDAP_URL3" ] ; then
    export AUTH_LDAP_URL3=
fi

# update AUTH_LDAP_GROUP_ATTR
if [ -z "$AUTH_LDAP_GROUP_ATTR" ] ; then
    export AUTH_LDAP_GROUP_ATTR=
fi

# update AUTH_LDAP_GROUP_ATTR2
if [ -z "$AUTH_LDAP_GROUP_ATTR2" ] ; then
    export AUTH_LDAP_GROUP_ATTR2=
fi

# update AUTH_LDAP_GROUP_ATTR3
if [ -z "$AUTH_LDAP_GROUP_ATTR3" ] ; then
    export AUTH_LDAP_GROUP_ATTR3=
fi

# update LDAP_CACHE_TTL
if [ -z "$LDAP_CACHE_TTL" ] ; then
    export LDAP_CACHE_TTL='60'
fi

# update PROXY_PATH3
if [ -z "$PROXY_PATH3" ] ; then
    export PROXY_PATH3=/register
fi

# update PROXY_URL3
if [ -z "$PROXY_URL3" ] ; then
    export PROXY_URL3=http://app:8080/register
fi

if [ "$ENABLE_STACKDRIVER" = "yes" ]; then
    /usr/sbin/a2ensite stackdriver
fi

if [ "$ENABLE_MODSECURITY" = "yes" ]; then
    /usr/sbin/a2enmod security2
    /usr/sbin/a2enmod unique_id
fi

if [ "$ENABLE_WEBSOCKET" = "yes" ]; then
    /usr/sbin/a2enmod proxy_wstunnel
fi

if [ "$ENABLE_REMOTEIP" = "yes" ]; then
    /usr/sbin/a2enmod remoteip
fi

# update FILTER
if [ -z "$FILTER" ] ; then
    export FILTER=
fi

# update FILTER2
if [ -z "$FILTER2" ] ; then
    export FILTER2=
fi

# update FILTER3
if [ -z "$FILTER3" ] ; then
    export FILTER3=
fi

if [ "$DISABLE_SSLPROXY_CHECKS" = "yes" ]; then
   export SSLPROXY_VERIFY="none"
   export SSLPROXY_CHECK_PEERCN="off"
   export SSLPROXY_CHECK_PEERNAME="off"
   export SSLPROXY_CHECK_PEEREXPIRE="off"
else
   export SSLPROXY_VERIFY="${SSLPROXY_VERIFY:-require}"
   export SSLPROXY_CHECK_PEERCN="${SSLPROXY_CHECK_PEERCN:-on}"
   export SSLPROXY_CHECK_PEERNAME="${SSLPROXY_CHECK_PEERNAME:-on}"
   export SSLPROXY_CHECK_PEEREXPIRE="${SSLPROXY_CHECK_PEEREXPIRE:-on}"
fi

# update SSL_LOG_LEVEL
if [ -z "$SSL_LOG_LEVEL" ] ; then
    export SSL_LOG_LEVEL=warn
fi
