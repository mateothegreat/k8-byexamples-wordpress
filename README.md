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

## Usage

```sh
$ make help
                                __                 __
   __  ______  ____ ___  ____ _/ /____  ____  ____/ /
  / / / / __ \/ __  __ \/ __  / __/ _ \/ __ \/ __  /
 / /_/ / /_/ / / / / / / /_/ / /_/  __/ /_/ / /_/ /
 \__, /\____/_/ /_/ /_/\__,_/\__/\___/\____/\__,_/
/____
                        yomateo.io, it ain't easy.

Usage: make <target(s)>

Targets:

  initdb               Create mysql database & grant (DROP DATABASE is performed!)
  git/update           Update submodule(s) to HEAD from origin
  install              Installs manifests to kubernetes using kubectl apply (make manifests to see what will be installed)
  delete               Deletes manifests to kubernetes using kubectl delete (make manifests to see what will be installed)
  get                  Retrieves manifests to kubernetes using kubectl get (make manifests to see what will be installed)
  describe             Describes manifests to kubernetes using kubectl describe (make manifests to see what will be installed)
  context              Globally set the current-context (default namespace)
  shell                Grab a shell in a running container
  dump/logs            Find first pod and follow log output
  dump/manifests       Output manifests detected (used with make install, delete, get, describe, etc)_/ / /_/ /
  ```

## Install

  ```sh
  $ make install LOADBALANCER_IP=35.224.16.183

[ INSTALLING MANIFESTS/SERVICE.YAML ]: service "wordpress" created
[ INSTALLING MANIFESTS/PERSISTENTVOLUMECLAIM.YAML ]: persistentvolumeclaim "wordpress" created
[ INSTALLING MANIFESTS/DEPLOYMENT.YAML ]: deployment "wordpress" created
[ INSTALLING MANIFESTS/INGRESS.YAML ]: ingress "wordpress.gcp.streaming-platform.com" created
[ INSTALLING MANIFESTS/NFS.YAML ]: error: no objects passed to apply
[ INSTALLING MANIFESTS/CERTIFICATE.YAML ]: certificate "wordpress.gcp.streaming-platform.com" created
[ INSTALLING MANIFESTS/CONFIGMAP.YAML ]: configmap "wordpress-config" created
```

## Cleanup

  ```sh
  $ make delete

[ DELETING MANIFESTS/SERVICE.YAML ]: service "wordpress" deleted
[ DELETING MANIFESTS/PERSISTENTVOLUMECLAIM.YAML ]: persistentvolumeclaim "wordpress" deleted
[ DELETING MANIFESTS/DEPLOYMENT.YAML ]: deployment "wordpress" deleted
[ DELETING MANIFESTS/INGRESS.YAML ]: ingress "wordpress.gcp.streaming-platform.com" deleted
[ DELETING MANIFESTS/NFS.YAML ]: No resources found
[ DELETING MANIFESTS/CERTIFICATE.YAML ]: certificate "wordpress.gcp.streaming-platform.com" deleted
[ DELETING MANIFESTS/CONFIGMAP.YAML ]: configmap "wordpress-config" deleted
  ```