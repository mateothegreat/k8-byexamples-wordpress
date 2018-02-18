#                                 __                 __
#    __  ______  ____ ___  ____ _/ /____  ____  ____/ /
#   / / / / __ \/ __ `__ \/ __ `/ __/ _ \/ __ \/ __  /
#  / /_/ / /_/ / / / / / / /_/ / /_/  __/ /_/ / /_/ /
#  \__, /\____/_/ /_/ /_/\__,_/\__/\___/\____/\__,_/
# /____                     matthewdavis.io, holla!
#
include .make/Makefile.inc

NS					?= default
APP					?= wordpress
SERVICE_NAME		?= $(APP)
SERVICE_PORT		?= 80
MYSQL_HOST	      	?= mysql
MYSQL_DATABASE      ?= wordpress
MYSQL_USER          ?= wordpress
MYSQL_PASSWORD      ?= wordpress
export

install: guard-SERVICE_NAME


## Create mysql database & grant (DROP DATABASE is performed!)
initdb:	

	mysql -h mysql -uroot -pmysql -e "DROP DATABASE wordpress"
	mysql -h mysql -uroot -pmysql -e "CREATE DATABASE wordpress"
	mysql -h mysql -uroot -pmysql -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress'@'10.28.%' IDENTIFIED BY 'wordpress'"
