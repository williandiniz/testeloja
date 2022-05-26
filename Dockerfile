
FROM registry.access.redhat.com/ubi8/ubi:8.1

RUN yum update -y 
RUN yum upgrade -y

RUN dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
RUN dnf install -y https://rpms.remirepo.net/enterprise/remi-release-8.rpm 
RUN dnf module enable php:remi-8.0 -y  
RUN dnf install php php-cli php-common -y
RUN dnf module enable php:remi-8.0 -y

RUN sed -i 's/Listen 80/Listen 8080/' /etc/httpd/conf/httpd.conf \
  && sed -i 's/listen.acl_users = apache,nginx/listen.acl_users =/' /etc/php-fpm.d/www.conf \
  && mkdir /run/php-fpm \
  && chgrp -R 0 /var/log/httpd /var/run/httpd /run/php-fpm \
  && chmod -R g=u /var/log/httpd /var/run/httpd /run/php-fpm
#RUN a2enmod rewrite
#RUN a2enmod headers
COPY info.php /var/www 
COPY info.php /usr/share/testpage/

COPY info.php /usr/share/doc/oniguruma5php/info1.php
COPY info.php /usr/share/doc/cyrus-sasl-lib/info2.php
COPY info.php /usr/share/testpage/info3.php
COPY info.php /usr/share/httpd/noindex/info4.php

EXPOSE 8080
USER 1001
CMD php-fpm & httpd -D FOREGROUND
