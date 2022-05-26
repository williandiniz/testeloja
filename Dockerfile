#FROM ubuntu:18.04
FROM ubuntu/apache2

RUN apt update -y &&\
    apt install nano -y 
   
