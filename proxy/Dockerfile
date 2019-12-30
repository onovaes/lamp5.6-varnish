FROM ubuntu:16.04

RUN apt-get update -y && apt-get install nano -y

RUN apt-get install nginx -y 

COPY sites-available/default /etc/nginx/sites-available/default

#SSL
RUN apt-get install openssl -y
COPY ssl/certs/nginx-selfsigned.crt /etc/ssl/certs/nginx-selfsigned.crt
COPY ssl/private/nginx-selfsigned.key /etc/ssl/private/nginx-selfsigned.key
COPY ssl/certs/dhparam.pem /etc/ssl/certs/dhparam.pem
RUN cd /etc/nginx/sites-enabled && ln -s /etc/nginx/sites-available/default-ssl

EXPOSE 80 443

#CMD ["nginx", "-g", "daemon off;"]

