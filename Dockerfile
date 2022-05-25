FROM php:8.1-apache

ENV BUILD_ENV=${BUILD_ENV:-dev}

RUN apt update -y &&\
    apt install nano -y &&\
    apt-get install libldb-dev libldap2-dev  -y

RUN apt install curl -y

WORKDIR /var/www/html
COPY . .
COPY .apache/. /etc/apache2/

RUN chmod -R 777 /var/www/html
RUN a2ensite webapi
RUN a2enmod rewrite
RUN a2enmod headers
RUN a2enmod proxy
RUN a2enmod proxy_http
EXPOSE 8080
USER 1001
RUN service apache2 restart
