FROM registry.access.redhat.com/ubi8/ubi:8.1

RUN yum update -y 
RUN yum upgrade -y


RUN yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN yum install https://rpms.remirepo.net/enterprise/remi-release-7.rpm
RUN subscription-manager repos --enable=rhel-7-server-optional-rpms
RUN yum install yum-utils
RUN yum-config-manager --enable remi-php81
RUN yum update
# Note: The php-pdo package is required only for the PDO_SQLSRV driver
RUN yum install php php-pdo php-pear php-devel
RUN  pecl install sqlsrv
RUN  pecl install pdo_sqlsrv
RUN  su
RUN  extension=pdo_sqlsrv.so >> `php --ini | grep "Scan for additional .ini files" | sed -e "s|.*:\s*||"`/30-pdo_sqlsrv.ini
RUN  extension=sqlsrv.so >> `php --ini | grep "Scan for additional .ini files" | sed -e "s|.*:\s*||"`/20-sqlsrv.ini
RUN yum install php-sqlsrv
RUN yum install httpd
RUN apachectl restart
