## LAMP para Desenvolvimento baseado no docker 

- Ubuntu 16 + APACHE 2.4 + PHP 5.6.22 + MYSQL 5.6.46 + VARNISH 4
- Autor: Gabriel Novaes <seproblema@gmail.com>

### Instalação
- $git clone https://github.com/onovaes/lamp5.6-varnish.git
- $cd lamp5.6-varnish
- $cp env-example .env
- $docker-compose up

### TODO'S
- Finalizar configuração do Proxy (Load Balancer) e balancear carga entre os web servers





## Informações Gerais

### LOGS
- Os logs do apache estão configurados para serem gerados na pasta setada na configuração (.env ) APACHE_HOST_LOG_PATH


### Informações Gerais

| CONTAINER NAME | HOST/PORT          | OBS                                                         |
| -------------- | ------------------ | ----------------------------------------------------------- |
| phpserver      | localhost:8080     | Ubuntu 16.04.6 LTS - Apache 2.4.18 + PHP 5.6 (SEM VARNISH)  |
| mysqldb        | mysqlserver:3306   | mysql 5.6.46                                                |
| phpmyadmin     | localhost:81       |                                                             |
| my-varnish     | localhost:80       | Ubuntu 16.04.6 LT + VARNISH 4 (COM VARNISH)                 |
