FROM 1and1internet/ubuntu-16-apache-php-5.6

LABEL maintainer="Gabriel Novaes <gabriel@dothcom.net>"

# Algumas ferramentas de rede e uso geral
RUN apt-get update -y \
	&& apt-get install -y net-tools iputils-ping \
	&& apt-get install nano -y 

# Proxy necessários para fazer a terminação de SSL necessaria para o Varnish
RUN a2enmod proxy && a2enmod proxy_balancer && a2enmod proxy_http

ENV DOCUMENT_ROOT ${DOCUMENT_ROOT}

COPY ports.conf /etc/apache2/ports.conf
COPY php.ini /etc/php/5.6/apache2/php.ini
COPY ssl/apache-selfsigned.crt /etc/ssl/certs/apache-selfsigned.crt
COPY ssl/apache-selfsigned.key /etc/ssl/private/apache-selfsigned.key