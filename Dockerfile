FROM broadinstitute/openidc-baseimage:2.3.1

ENV OWASP_VERSION=3.0.0

RUN apt-get update && \
    apt-get install libapache2-mod-security2 -y && \
    a2dismod security2 unique_id && \
    echo "Installing OWASP rules version  (${OWASP_VERSION})..." && \
    curl -L https://github.com/SpiderLabs/owasp-modsecurity-crs/archive/v${OWASP_VERSION}.tar.gz -o /root/v${OWASP_VERSION}.tar.gz && \
    cd /root && \
    tar xzf v${OWASP_VERSION}.tar.gz && \
    cd owasp-modsecurity-crs-${OWASP_VERSION} && \
    cp -rfp rules/REQUEST-921-PROTOCOL-ATTACK.conf \
      rules/REQUEST-930-APPLICATION-ATTACK-LFI.conf \
      rules/REQUEST-931-APPLICATION-ATTACK-RFI.conf \
      rules/REQUEST-932-APPLICATION-ATTACK-RCE.conf \
      rules/REQUEST-941-APPLICATION-ATTACK-XSS.conf \
      rules/REQUEST-942-APPLICATION-ATTACK-SQLI.conf \
      rules/RESPONSE-951-DATA-LEAKAGES-SQL.conf \
      rules/*.data /etc/modsecurity/ && \
    rm /root/v${OWASP_VERSION}.tar.gz && \
    echo "Cleaning up..." && \
    apt-get -yq autoremove && \
    apt-get -yq clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* && \
    rm -rf /var/tmp/*
    
ADD modsecurity.conf /etc/modsecurity/modsecurity.conf

ADD site.conf stackdriver.conf /etc/apache2/sites-available/
ADD override.sh /etc/apache2/

RUN a2enmod authnz_ldap

