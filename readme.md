# Ambiente LAMP para Desenvolvimento baseado no docker 

- Ubuntu 16 + APACHE 2.4 + PHP 5.6.22 + MYSQL 5.6.22 + VARNISH 4
- Autor: Gabriel Novaes <gabriel@dothcom.net>

## Instalação
- $git clone git@github.com:onovaes/lamp5.6-varnish.git
- $cd lamp5.6-varnish
- $cp env-example .env
- $docker-compose up


## TODO'S
- Finalizar configuração do Proxy (Load Balancer) e balancear carga entre os web servers


## Informações Gerais

| CONTAINER NAME | HOST/PORT          | OBS                                                         |
| -------------- | ------------------ | ----------------------------------------------------------- |
| phpserver      | localhost:8080     | Ubuntu 16.04.6 LTS - Apache 2.4.18 + PHP 5.6 (SEM VARNISH)  |
| mysqldb        | mysqlserver:3306   | mysql 5.6.22                                                |
| phpmyadmin     | localhost:81       |                                                             |
| my-varnish     | localhost:80       | Ubuntu 16.04.6 LT + VARNISH 4 (COM VARNISH)                 |
