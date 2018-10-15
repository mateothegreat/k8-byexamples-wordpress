#                                 __                 __
#    __  ______  ____ ___  ____ _/ /____  ____  ____/ /
#   / / / / __ \/ __ `__ \/ __ `/ __/ _ \/ __ \/ __  /
#  / /_/ / /_/ / / / / / / /_/ / /_/  __/ /_/ / /_/ /
#  \__, /\____/_/ /_/ /_/\__,_/\__/\___/\____/\__,_/
# /____                     matthewdavis.io, holla!
#
include .make/Makefile.inc

NS					?= default
APP					?= wp-workflow-host
HOST				?= matthewdavis.io
SERVICE_NAME		?= $(APP)
SERVICE_PORT		?= 80
MYSQL_HOST			?= 
MYSQL_DATABASE		?= 
MYSQL_USER			?= 
MYSQL_PASSWORD		?= 
GCE_ZONE			?= us-central1-a
GCE_DISK			?= $(APP)

## Create disk
create-disk:

	gcloud compute disks create $(GCE_DISK) --zone $(GCE_ZONE) --size 10

install: 	guard-APP  
delete:		guard-APP 

## Create mysql database & grant (DROP DATABASE is performed!)
initdb:	

	@nslookup $(MYSQL_HOST)

	mysql -h $(MYSQL_HOST) -uroot -pmysql -e "CREATE DATABASE IF NOT EXISTS \`$(MYSQL_DATABASE)\`"
	mysql -h $(MYSQL_HOST) -uroot -pmysql -e "GRANT ALL PRIVILEGES ON \`$(MYSQL_DATABASE)\`.* TO '$(MYSQL_USER)'@'10.%' IDENTIFIED BY '$(MYSQL_PASSWORD)'"

dropdb: 

	@nslookup $(MYSQL_HOST)
	@mysql -h $(MYSQL_HOST) -uroot -pmysql -e "DROP DATABASE IF EXISTS \`$(MYSQL_DATABASE)\`" | true

## Create Ingress Resource
ingress-issue:

	cd k8-byexamples-ingress-controller && git submodule update --init

	$(MAKE) -C k8-byexamples-ingress-controller ingress-issue

## Create LetsEncrypt Certificate Request
certificate-issue:

	cd k8-byexamples-ingress-controller && git submodule update --init

	$(MAKE) -C k8-byexamples-ingress-controller certificate-issue
