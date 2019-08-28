FROM broadinstitute/openidc-baseimage:2.3.11-20190820

ENV MODSEC_VERSION=2.9.3 \
    OWASP_VERSION=3.1.1

COPY override.sh /etc/apache2/
COPY site.conf /etc/apache2/sites-available/
COPY mod_security/security2.load mod_security/security2.conf /etc/apache2/mods-available/

RUN apt-get update && \
    apt-get upgrade -qy && \
    apt-get install -qy --no-install-recommends apache2-dev libyajl-dev libpcre3 libpcre3-dev libxml2-dev lua5.1 lua5.1-dev python wget && \
    a2enmod authnz_ldap && \
    curl -L -o "/tmp/modsecurity-${MODSEC_VERSION}.tar.gz" "https://github.com/SpiderLabs/ModSecurity/releases/download/v${MODSEC_VERSION}/modsecurity-${MODSEC_VERSION}.tar.gz" && \
    curl -L -o "/tmp/modsecurity-${MODSEC_VERSION}.tar.gz.sha256" "https://github.com/SpiderLabs/ModSecurity/releases/download/v${MODSEC_VERSION}/modsecurity-${MODSEC_VERSION}.tar.gz.sha256" && \
    cd /tmp && \
    sha256sum -c "modsecurity-${MODSEC_VERSION}.tar.gz.sha256" && \
    tar -xvzf "modsecurity-${MODSEC_VERSION}.tar.gz" && \
    cd "modsecurity-${MODSEC_VERSION}" && \
    ./configure --with-apxs=/usr/bin/apxs && \
    make && \
    make install && \
    mkdir -p /var/cache/modsecurity && \
    chmod -R 777 /var/cache/modsecurity && \
    mkdir -p /etc/modsecurity && \
    mkdir -p /usr/share/modsecurity/rules && \
    curl -L -o "/tmp/v${OWASP_VERSION}.tar.gz" "https://github.com/SpiderLabs/owasp-modsecurity-crs/archive/v${OWASP_VERSION}.tar.gz" && \
    cd /tmp && \
    tar -xvzf "v${OWASP_VERSION}.tar.gz" && \
    cd "owasp-modsecurity-crs-${OWASP_VERSION}" && \
    cp -rfp rules/* /usr/share/modsecurity/rules && \
    mkdir rulesworking && \
    mkdir rulesfinal && \
    cp -rfp rules/REQUEST-921-PROTOCOL-ATTACK.conf \
      rules/REQUEST-930-APPLICATION-ATTACK-LFI.conf \
      rules/REQUEST-931-APPLICATION-ATTACK-RFI.conf \
      rules/REQUEST-932-APPLICATION-ATTACK-RCE.conf \
      rules/REQUEST-941-APPLICATION-ATTACK-XSS.conf \
      rules/REQUEST-942-APPLICATION-ATTACK-SQLI.conf \
      rules/RESPONSE-951-DATA-LEAKAGES-SQL.conf rulesworking/ && \
    util/join-multiline-rules/join.py rulesworking/*.conf > rulesfinal/rules.conf && \
    cp -rfp rulesfinal/* /etc/modsecurity && \
    cp -rfp rules/*.data /etc/modsecurity/ && \
    apt-get -yq autoremove && \
    apt-get -yq clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* && \
    rm -rf /var/tmp/*

COPY mod_security/modsecurity.conf mod_security/unicode.mapping /etc/modsecurity/
