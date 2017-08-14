FROM broadinstitute/openidc-baseimage:2.3.1

ADD site.conf stackdriver.conf /etc/apache2/sites-available/
ADD override.sh /etc/apache2/

RUN a2enmod authnz_ldap
