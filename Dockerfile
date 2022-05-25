FROM php:7.3-apache

ENV BUILD_ENV=${BUILD_ENV:-dev}

RUN apt update -y &&\
    apt install nano -y &&\
    apt-get install libldb-dev libldap2-dev  -y
#--------------
#RUN apt install curl -y

#RUN apt-get install php7.3-dev php7.3-xml -y --allow-unauthenticated

#RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
#RUN curl https://packages.microsoft.com/config/ubuntu/18.04/prod.list > /etc/apt/sources.list.d/mssql-release.list
#RUN apt-get update
#------------------
# Install git
RUN apt-get update \
    && apt-get -y install git
#Install ODBC Driver
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/config/debian/9/prod.list > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update

# Install sqlsrv
RUN apt-get update
RUN apt-get install -y wget
RUN wget http://ftp.br.debian.org/debian/pool/main/g/glibc/multiarch-support_2.24-11+deb9u4_amd64.deb && \
    dpkg -i multiarch-support_2.24-11+deb9u4_amd64.deb
RUN apt-get -y install msodbcsql17 unixodbc-dev
RUN pecl install sqlsrv pdo_sqlsrv


WORKDIR /var/www/html
COPY . .
COPY apache/. /etc/apache2/

RUN chmod -R 777 /var/www/html
RUN a2ensite webapi
RUN a2enmod rewrite
RUN a2enmod headers
RUN a2enmod proxy
RUN a2enmod proxy_http
EXPOSE 8080
USER 1001
RUN service apache2 restart
