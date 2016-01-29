FROM broadinstitute/openidc-baseimage:latest

ADD site.conf /etc/apache2/sites-available/site.conf
ADD override.sh /etc/apache2/

RUN a2enmod authnz_ldap
