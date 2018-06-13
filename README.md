<!--
#                                 __                 __
#    __  ______  ____ ___  ____ _/ /____  ____  ____/ /
#   / / / / __ \/ __ `__ \/ __ `/ __/ _ \/ __ \/ __  /
#  / /_/ / /_/ / / / / / / /_/ / /_/  __/ /_/ / /_/ /
#  \__, /\____/_/ /_/ /_/\__,_/\__/\___/\____/\__,_/
# /____                     matthewdavis.io, holla!
#
#-->

[![Clickity click](https://img.shields.io/badge/k8s%20by%20example%20yo-limit%20time-ff69b4.svg?style=flat-square)](https://k8.matthewdavis.io)
[![Twitter Follow](https://img.shields.io/twitter/follow/yomateod.svg?label=Follow&style=flat-square)](https://twitter.com/yomateod) [![Skype Contact](https://img.shields.io/badge/skype%20id-appsoa-blue.svg?style=flat-square)](skype:appsoa?chat)

# Wordpress @ Kubernetes

> k8 by example -- straight to the point, simple execution.

* Tuned settings to allow large file uploads.
* Disabled "X-Powered-By: php7.6" response headers.

## Create Persistent Disk
```bash
$ make create-disk
     
    gcloud compute disks create wp-matthewdavis-io --zone us-central1-a --size 10
    
    Created [https://www.googleapis.com/compute/v1/projects/streaming-platform-devqa/zones/us-central1-a/disks/wp-matthewdavis-io].
    
    NAME                ZONE           SIZE_GB  TYPE         STATUS
    wp-matthewdavis-io  us-central1-a  10       pd-standard  READY
```
## Install

```sh
$ make install MYSQL_HOST=some.mysql.host.com MYSQL_USER=someuser MYSQL_password=supersecret MYSQL_DATABASE=my_wordpress

    [ INSTALLING MANIFESTS/CONFIGMAP.YAML ]: configmap "wordpress-config" created
    [ INSTALLING MANIFESTS/STORAGE-PERSISTENTVOLUMECLAIM.YAML ]: persistentvolumeclaim "wp-matthewdavis-io-volume" created
    [ INSTALLING MANIFESTS/STORAGE-PERSISTENTVOLUME.YAML ]: persistentvolume "es-data" created
    [ INSTALLING MANIFESTS/SERVICE.YAML ]: service "wp-matthewdavis-io" created
    [ INSTALLING MANIFESTS/DEPLOYMENT.YAML ]: deployment "wp-matthewdavis-io" created
```
## Setup Ingress & LetsEncrypt Certificate
In order to route http traffic to our new wordpress pod we can either change the service type to `LoadBalancer` or use
an `Ingress` resource. This is handled by the submodule `k8-byexamples-ingress-controller` (included in this repo) which
will auto-magically create the `Ingress` resource for you:

```bash
make ingress-issue HOST=matthewdavis.io

    make[1]: Entering directory '/workspace/k8-byexamples-monorepo/modules/k8-byexamples-wordpress/k8-byexamples-ingress-controller'
    ingress "matthewdavis.io" created
```

Now lets request a certificate from LetsEncrypt (see: https://github.com/mateothegreat/k8-byexamples-cert-manager):

```bash
$ make certificate-issue 

    make[1]: Entering directory '/workspace/k8-byexamples-monorepo/modules/k8-byexamples-wordpress/k8-byexamples-ingress-controller'
    certificate "matthewdavis.io" created
```
## Usage

```sh
$  make help
  
                                  __                 __
     __  ______  ____ ___  ____ _/ /____  ____  ____/ /
    / / / / __ \/ __  __ \/ __  / __/ _ \/ __ \/ __  / 
   / /_/ / /_/ / / / / / / /_/ / /_/  __/ /_/ / /_/ /  
   \__, /\____/_/ /_/ /_/\__,_/\__/\___/\____/\__,_/   
  /____                                                
                          yomateo.io, it ain't easy.   
  
  Usage: make <target(s)>
  
  Targets:
  
    create-disk          Create disk
    initdb               Create mysql database & grant (DROP DATABASE is performed!)
    ingress-issue        Create Ingress Resource
    certificate-issue    Create LetsEncrypt Certificate Request
    dump/submodules      Output list of submodules & repositories
    install              Installs manifests to kubernetes using kubectl apply (make manifests to see what will be installed)
    delete               Deletes manifests to kubernetes using kubectl delete (make manifests to see what will be installed)
    get                  Retrieves manifests to kubernetes using kubectl get (make manifests to see what will be installed)
    get/all              Retrives all resources (in color!)
    describe             Describes manifests to kubernetes using kubectl describe (make manifests to see what will be installed)
    context              Globally set the current-context (default namespace)
    shell                Grab a shell in a running container
    dump/logs            Find first pod and follow log output
    dump/manifests       Output manifests detected (used with make install, delete, get, describe, etc)
  
  
  Tools:
  
    get/myip              Get your external ip
    testing-curl          Try to curl http & https from $(HOST)
    testing/curlhttp      Try to curl http://$(HOST)
    testing/curlhttps     Try to curl https://$(HOST)
    testing/getip         Retrieve external IP from api.ipify.org
    git/update            Update submodule(s) to HEAD from origin
    git/up                Update all .make submodules
    rbac/grant-google     Create clusterrolebinding for cluster-admin
  ```

## Cleanup

  ```sh
  $ make delete

[ DELETING MANIFESTS/SERVICE.YAML ]: service "wordpress" deleted
[ DELETING MANIFESTS/PERSISTENTVOLUMECLAIM.YAML ]: persistentvolumeclaim "wordpress" deleted
[ DELETING MANIFESTS/DEPLOYMENT.YAML ]: deployment "wordpress" deleted
[ DELETING MANIFESTS/INGRESS.YAML ]: ingress "wordpress.gcp.streaming-platform.com" deleted
[ DELETING MANIFESTS/CERTIFICATE.YAML ]: certificate "wordpress.gcp.streaming-platform.com" deleted
[ DELETING MANIFESTS/CONFIGMAP.YAML ]: configmap "wordpress-config" deleted
  ```