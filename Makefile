#                                 __                 __
#    __  ______  ____ ___  ____ _/ /____  ____  ____/ /
#   / / / / __ \/ __ `__ \/ __ `/ __/ _ \/ __ \/ __  /
#  / /_/ / /_/ / / / / / / /_/ / /_/  __/ /_/ / /_/ /
#  \__, /\____/_/ /_/ /_/\__,_/\__/\___/\____/\__,_/
# /____                     matthewdavis.io, holla!
#
include .make/Makefile.inc

NS					?= default
APP					?= 
SERVICE_NAME		?= $(APP)
SERVICE_PORT		?= 80
MYSQL_HOST	      	?= mysql
MYSQL_DATABASE      ?= $(APP)
MYSQL_USER          ?= wordpress
MYSQL_PASSWORD      ?= wordpress
export

install: 	guard-APP dropdb initdb 
delete:		guard-APP dropdb

## Create mysql database & grant (DROP DATABASE is performed!)
initdb:	

	mysql -h mysql -uroot -pmysql -e "CREATE DATABASE \`$(MYSQL_DATABASE)\`"
	mysql -h mysql -uroot -pmysql -e "GRANT ALL PRIVILEGES ON \`$(MYSQL_DATABASE)\`.* TO '$(MYSQL_USER)'@'10.%' IDENTIFIED BY '$(MYSQL_PASSWORD)'"

dropdb: ; mysql -h mysql -uroot -pmysql -e "DROP DATABASE IF EXISTS \`$(MYSQL_DATABASE)\`" | true
