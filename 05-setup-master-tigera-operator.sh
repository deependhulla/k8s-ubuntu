#!/bin/bash

## only for custom
#podnetwork="10.11.0.0/16"
#servicenetwork="192.168.107.0/24"
#masterhost="192.168.64.9"
#sed -i "s#10.85.0.0/16#$podnetwork#g" /etc/cni//net.d/11-crio-ipv4-bridge.conflist 

export KUBECONFIG=/etc/kubernetes/admin.conf


# only for custom

kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml

#kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.28.1/manifests/tigera-operator.yaml

#kubectl create -f files/calico-network/tigera-operator.yaml
#kubectl get pods -n tigera-operator


#/bin/cp files/calico-network/custom-resources.yaml /tmp/custom-resources.yaml
#only for custom
##sed -i "s#10.244.0.0/16#$podnetwork#g" /tmp/custom-resources.yaml

#kubectl create -f /tmp/custom-resources.yaml

## show CALICO System
#kubectl get pods -n calico-system
## show KUBE System
kubectl get pods -n kube-system


