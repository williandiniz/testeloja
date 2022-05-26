FROM registry.access.redhat.com/ubi8/ubi:8.1

RUN yum update -y 
RUN yum upgrade -y

#RUN dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
#RUN dnf install -y https://rpms.remirepo.net/enterprise/remi-release-8.rpm 
#RUN dnf module enable php:remi-8.0 -y  
#RUN dnf install php php-cli php-common -y
#RUN dnf module enable php:remi-8.0 -y
RUN yum install httpd -y

RUN sed -i 's/Listen 80/Listen 8080/' /etc/httpd/conf/httpd.conf \
&& chgrp -R 0 /var/log/httpd /var/run/httpd \
&& chmod -R g=u /var/log/httpd /var/run/httpd

#RUN a2enmod rewrite
#RUN a2enmod headers
COPY info.php /var/www/index1.php 
COPY info.php /usr/share/testpage/index2.php

COPY info.php /usr/share/doc/oniguruma5php/index3.php
COPY info.php /usr/share/doc/cyrus-sasl-lib/index4.php
COPY info.php /usr/share/testpage/index5.php
COPY info.php /usr/share/httpd/noindex/index6.php
RUN rm /usr/share/doc/cyrus-sasl-lib/index.html
RUN echo 'Hello, docker /usr/share/testpage/index.html ' > /usr/share/testpage/index.html
RUN echo 'Hello, docker /usr/share/httpd/noindex/index.html' > /usr/share/httpd/noindex/index.html
#RUN rm /usr/share/httpd/noindex/index.html
#RUN rm /usr/share/testpage/index.html

EXPOSE 8080
USER 1001
CMD httpd -D FOREGROUND
