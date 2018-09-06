FROM broadinstitute/openidc-baseimage:dev

RUN apt-get update && \
    apt-get install -qy python libpcre3 libpcre3-dev  git  apache2-dev wget libxml2-dev lua5.1 lua5.1-dev && \
    cd /root && \
    wget https://github.com/SpiderLabs/ModSecurity/releases/download/v2.9.2/modsecurity-2.9.2.tar.gz && \
    tar -xvzf modsecurity-2.9.2.tar.gz && \
    cd modsecurity-2.9.2 && \
    ./configure --with-apxs=/usr/bin/apxs && \
    make && \
    make install && \
    mkdir -p /var/cache/modsecurity && \
    chmod -R 777 /var/cache/modsecurity && \
    mkdir -p /etc/modsecurity && \
    apt-get -yq autoremove && \
    apt-get -yq clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* && \
    rm -rf /var/tmp/*
    
ADD security2.load /etc/apache2/mods-available/security2.load
ADD security2.conf /etc/apache2/mods-available/security2.conf

RUN cd /root && \
    wget https://github.com/SpiderLabs/owasp-modsecurity-crs/archive/v3.0.2.tar.gz && \
    tar -xvzf v3.0.2.tar.gz && \
    cd owasp-modsecurity-crs-3.0.2 && \
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
      cp -rfp rules/*.data /etc/modsecurity/

ADD modsecurity.conf /etc/modsecurity/modsecurity.conf
ADD unicode.mapping /etc/modsecurity/unicode.mapping

ADD site.conf stackdriver.conf /etc/apache2/sites-available/
ADD override.sh /etc/apache2/

RUN a2enmod authnz_ldap
