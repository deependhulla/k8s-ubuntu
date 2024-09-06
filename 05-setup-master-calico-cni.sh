#!/bin/bash



#https://kubernetes.io/docs/concepts/cluster-administration/addons/#networking-and-network-policy

#Calico is a networking and network policy provider. 
#Calico supports a flexible set of networking options so you can choose the most efficient option for your situation, 
#including non-overlay and overlay networks, with or without BGP.
#Calico uses the same engine to enforce network policy for hosts, pods, and (if using Istio & Envoy) applications at the service mesh layer.


## only for custom
#podnetwork="10.11.0.0/16"
#servicenetwork="192.168.107.0/24"
#masterhost="192.168.64.9"
#sed -i "s#10.85.0.0/16#$podnetwork#g" /etc/cni//net.d/11-crio-ipv4-bridge.conflist 

export KUBECONFIG=/etc/kubernetes/admin.conf



## download calico ctl before config
#cd /tmp/
#curl -L https://github.com/projectcalico/calico/releases/download/v3.28.0/calicoctl-linux-amd64 -o kubectl-calico
#chmod +x kubectl-calico
#/bin/cp -p /tmp/kubectl-calico /usr/bin/
#cd -
#kubectl calico -h



# only for custom

kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml

echo "Wait for few seconds"
sleep 10;echo -n "."
sleep 10;echo -n "."
sleep 10;echo -n "."
kubectl get pods -o wide -A


