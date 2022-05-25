FROM ubuntu:18.04


RUN apt update -y &&\
    apt install nano -y && 
    #apt install apache2 -y
#--------------
#RUN apt install curl -y

#RUN apt-get install php7.3-dev php7.3-xml -y --allow-unauthenticated

#RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
#RUN curl https://packages.microsoft.com/config/ubuntu/18.04/prod.list > /etc/apt/sources.list.d/mssql-release.list
#RUN apt-get update
#------------------
