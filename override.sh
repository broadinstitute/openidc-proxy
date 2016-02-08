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
