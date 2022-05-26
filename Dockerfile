FROM registry.access.redhat.com/ubi8/ubi:8.1

RUN yum update -y 
RUN yum upgrade -y

RUN dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
RUN dnf install -y https://rpms.remirepo.net/enterprise/remi-release-8.rpm 
#RUN dnf module enable php:remi-8.0 -y  
#RUN dnf install php php-cli php-common -y

RUN yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN yum install https://rpms.remirepo.net/enterprise/remi-release-7.rpm
RUN subscription-manager repos --enable=rhel-7-server-optional-rpms
RUN yum install yum-utils
RUN yum-config-manager --enable remi-php81
RUN yum update
RUN yum install php php-pdo php-pear php-devel


#RUN yum --disableplugin=subscription-manager -y module enable php:8 \
 # && yum --disableplugin=subscription-manager -y install httpd php \
  #&& yum --disableplugin=subscription-manager clean all

ADD index.php /var/www/html
ADD info.php /var/www/html
ADD teste.php /var/www/html

RUN sed -i 's/Listen 80/Listen 8080/' /etc/httpd/conf/httpd.conf \
  && sed -i 's/listen.acl_users = apache,nginx/listen.acl_users =/' /etc/php-fpm.d/www.conf \
  && mkdir /run/php-fpm \
  && chgrp -R 0 /var/log/httpd /var/run/httpd /run/php-fpm \
  && chmod -R g=u /var/log/httpd /var/run/httpd /run/php-fpm

EXPOSE 8080
USER 1001
CMD php-fpm & httpd -D FOREGROUND
