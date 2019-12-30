FROM 1and1internet/ubuntu-16-apache-php-5.6

LABEL maintainer="Gabriel Novaes <gabriel@dothcom.net>"

# Some tools for networks
RUN apt-get update && apt-get install -y net-tools iputils-ping

RUN apt-get install nano -y

# Proxy necessários para fazer a terminação de SSL
# https://bash-prompt.net/guides/apache-varnish/
RUN a2enmod proxy && a2enmod proxy_balancer && a2enmod proxy_http

ENV DOCUMENT_ROOT ${DOCUMENT_ROOT}

COPY ports.conf /etc/apache2/ports.conf
COPY php.ini /etc/php/5.6/apache2/php.ini

# Copia as chaves do ssl auto assinado
COPY ssl/apache-selfsigned.crt /etc/ssl/certs/apache-selfsigned.crt
COPY ssl/apache-selfsigned.key /etc/ssl/private/apache-selfsigned.key