#!/bin/bash



export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

helm repo add portainer https://portainer.github.io/k8s/
helm repo update

helm install --create-namespace -n portainer portainer portainer/portainer

