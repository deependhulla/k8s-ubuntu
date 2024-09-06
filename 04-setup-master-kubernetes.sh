#!/bin/bash

## only for custom
podnetwork="10.85.0.0/16"
#servicenetwork="192.168.107.0/24"
#masterhost="192.168.64.9"
#sed -i "s#10.85.0.0/16#$podnetwork#g" /etc/cni//net.d/11-crio-ipv4-bridge.conflist 


systemctl restart crio
systemctl restart kubelet

export KUBECONFIG=/etc/kubernetes/admin.conf


# only for custom
#kubeadm init --pod-network-cidr=$podnetwork --service-cidr=$servicenetwork --control-plane-endpoint=$masterhost
#kubeadm init 

kubeadm init --pod-network-cidr=$podnetwork

echo "Wait for few  seconds..."
#sleep for init to finish
sleep 10

kubectl get nodes

#kubectl create -f files/calico-network/tigera-operator.yaml
#/bin/cp files/calico-network/custom-resources.yaml /tmp/custom-resources.yaml
#only for custom
##sed -i "s#10.244.0.0/16#$podnetwork#g" /tmp/custom-resources.yaml

#kubectl create -f /tmp/custom-resources.yaml

kubectl get pods -n kube-system

kubectl cluster-info

