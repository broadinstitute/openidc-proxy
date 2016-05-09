FROM broadinstitute/openidc-baseimage:latest

ADD site.conf stackdriver.conf /etc/apache2/sites-available/
ADD mpm_event.conf mpm_worker.conf /etc/apache2/mods-available/
ADD override.sh /etc/apache2/

RUN a2enmod authnz_ldap
