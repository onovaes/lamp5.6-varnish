# Ambiente LAMP para Desenvolvimento - Ubuntu 16 + APACHE 2.4 + PHP 5.6.22 + MYSQL 5.6.22 + VARNISH 4

Autor Gabriel Novaes <gabriel@dothcom.net>

CONTAINER 	HOST/PORT				OBS
- phpserver	localhost:8080 			- Ubuntu 16.04.6 LTS - Apache 2.4.18 + PHP 5.6  (Todos os dothnews - localhost.site.com.br)
- phpserver	localhost:8081 			- Ubuntu 16.04.6 LTS - Apache 2.4.18 + PHP 5.6  (Outros sites e testes)
- mysqldb		3306 					- mysql 5.6.22
- phpmyadmin	localhost:81 			- 
- my-varnish	localhost:80			- Ubuntu 16.04.6 LT + VARNISH 4 
- proxy	 	XX 						- Ubuntu 16.04.6 LT + VARNISH 4 http://localhost


## Iniciando containers
- git clone git@github.com:onovaes/lamp5.6-varnish.git
- cd lamp5.6-varnish
- cp env-example .env
- docker-compose up


## Alguns comandos úteis

Entrando num container em execução
- docker exec -ti phpserver bash
- docker exec -ti mysqlserver bash


## TODO'S
- Conferir passos para instalação MYSQL
- Finalizar configuração do Proxy Load Balancer


