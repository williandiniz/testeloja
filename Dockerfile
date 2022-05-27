FROM registry.access.redhat.com/ubi8/ubi:8.1

RUN yum update -y 
RUN yum upgrade -y

RUN dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
RUN dnf install -y https://rpms.remirepo.net/enterprise/remi-release-8.rpm 
RUN dnf module enable php:remi-8.0 -y  
RUN dnf install php php-cli php-common php-pdo php-pear php-devel -y
RUN curl https://packages.microsoft.com/config/rhel/8/prod.repo > /etc/yum.repos.d/mssql-release.repo
RUN yum update -y 
RUN ACCEPT_EULA=Y yum install -y msodbcsql17
#RUN ACCEPT_EULA=Y yum install -y mssql-tools17
RUN echo 'export PATH="$PATH:/opt/mssql-tools17/bin"' >> ~/.bashrc
RUN source ~/.bashrc
# optional: for unixODBC development headers
#RUN yum install -y unixODBC-devel




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
