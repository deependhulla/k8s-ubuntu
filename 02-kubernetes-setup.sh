#!/bin/bash

CRIO_VERSION=v1.30
KUBERNETES_VERSION=v1.31
CALICO_VERSION=v3.28.1



## remove if installed
apt-get -y remove containerd
apt-get -y purge containerd

export KUBECONFIG=/etc/kubernetes/admin.conf

curl -fsSL https://pkgs.k8s.io/addons:/cri-o:/stable:/$CRIO_VERSION/deb/Release.key |
    gpg --dearmor -o /etc/apt/keyrings/cri-o-apt-keyring.gpg

echo "deb [signed-by=/etc/apt/keyrings/cri-o-apt-keyring.gpg] https://pkgs.k8s.io/addons:/cri-o:/stable:/$CRIO_VERSION/deb/ /" |
    tee /etc/apt/sources.list.d/cri-o.list

curl -fsSL https://pkgs.k8s.io/core:/stable:/$KUBERNETES_VERSION/deb/Release.key |
    gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/$KUBERNETES_VERSION/deb/ /" |
    tee /etc/apt/sources.list.d/kubernetes.list

apt-get update
apt-get install -y  kubelet kubeadm kubectl 

## check and print version
kubectl version --client

# below command firs time would gert error
# The connection to the server <server-name:port> was refused - did you specify the right host or port?
#kubectl cluster-info dump

# https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#install-using-native-package-management
# Enable kubectl autocompletion
kubectl completion bash | sudo tee /etc/bash_completion.d/kubectl > /dev/null
sudo chmod a+r /etc/bash_completion.d/kubectl
source ~/.bashrc

systemctl start crio.service


sudo systemctl enable kubelet
sudo systemctl start kubelet



