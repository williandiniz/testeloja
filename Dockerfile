FROM ubuntu:18.04

ENV CONTAINER_TIMEZONE="America/Sao_Paulo"

RUN ln -snf /usr/share/zoneinfo/$CONTAINER_TIMEZONE /etc/localtime && echo $CONTAINER_TIMEZONE > /etc/timezone

RUN apt update && apt install -y apache2

WORKDIR /var/www/html
#COPY . .
#COPY apache/. /etc/apache2/

RUN sed -i 's/Listen 80/Listen 8080/' /etc/apache2/ports.conf \
RUN mkdir /tmp/apache
RUN chmod 777 /tmp/apache
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /tmp/apache
ENV APACHE_RUN_DIR /var/www/html
#RUN chmod 777 /var/log/apache2/error.log

RUN /usr/sbin/apache2 -V


RUN echo 'Hello, docker' > /var/www/index.html
ENTRYPOINT ["/usr/sbin/apache2"]
CMD ["-D", "FOREGROUND"]
RUN service apache2 start
