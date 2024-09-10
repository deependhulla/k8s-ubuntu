#!/bin/bash


#Kubernetes native -- configuration management
#Kustomize introduces a template-free way to customize application configuration that simplifies the use of off-the-shelf applications.
# Now, built into kubectl as apply -k.

#https://kustomize.io/

## https://kubectl.docs.kubernetes.io/installation/kustomize/binaries/

cd /usr/local/bin/
curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash
cd -
