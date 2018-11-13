FROM broadinstitute/openidc-baseimage:3.0
ENV MOD_SECURITY_VERSION=2.9.2

RUN apt-get update && \
    apt-get install -qy libyajl-dev python libpcre3 libpcre3-dev  git  apache2-dev wget libxml2-dev lua5.1 lua5.1-dev && \
    cd /root && \
    wget https://github.com/SpiderLabs/ModSecurity/releases/download/v${MOD_SECURITY_VERSION}/modsecurity-${MOD_SECURITY_VERSION}.tar.gz && \
    tar -xvzf modsecurity-${MOD_SECURITY_VERSION}.tar.gz && \
    cd modsecurity-${MOD_SECURITY_VERSION} && \
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

COPY security2.load /etc/apache2/mods-available/security2.load
COPY security2.conf /etc/apache2/mods-available/security2.conf

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

COPY modsecurity.conf /etc/modsecurity/modsecurity.conf
COPY unicode.mapping /etc/modsecurity/unicode.mapping

COPY site.conf stackdriver.conf /etc/apache2/sites-available/
COPY override.sh /etc/apache2/

RUN rm -f /root/modsecurity-${MOD_SECURITY_VERSION}.tar.gz
RUN rm -rf /root/modsecurity-${MOD_SECURITY_VERSION}

RUN cd /root && wget https://static.tcell.io/downloads/apacheagent/apache24_tcellagent-1.2.1-linux-x86_64.tgz && \ 
    tar -xzf apache24_tcellagent-1.2.1-linux-x86_64.tgz && \
    mkdir /etc/apache2/modules && \
    cp -rfp apache_tcellagent-1.2.1-linux-x86_64/ubuntu/mod_agenttcell.so /etc/apache2/modules/mod_agenttcell.so && \
    chown -R www-data:www-data /var/log/apache2 && chmod -R 777 /var/log/apache2

COPY tcell.load /etc/apache2/mods-available/tcell.load
RUN a2enmod authnz_ldap
