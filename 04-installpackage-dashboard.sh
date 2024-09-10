#!/bin/bash

## DNS to check
#https://kubernetes.io/docs/tasks/administer-cluster/dns-debugging-resolution/

#export KUBECONFIG=/etc/kubernetes/admin.conf

export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

#https://github.com/kubernetes/dashboard#kubernetes-dashboard
# Add kubernetes-dashboard repository
helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/
# Deploy a Helm Release named "kubernetes-dashboard" using the kubernetes-dashboard chart
helm upgrade --install kubernetes-dashboard kubernetes-dashboard/kubernetes-dashboard --create-namespace --namespace kubernetes-dashboard

#You can reference the document:
#https://github.com/kubernetes/dashboard/blob/master/docs/user/accessing-dashboard/README.md
#The easy way is to
#$ kubectl -n kube-system edit service kubernetes-dashboard

#change the .spec.type to NodePort

#kubectl -n kubernetes-dashboard edit service kubernetes-dashboard-kong-proxy
#kubectl -n kubernetes-dashboard port-forward svc/kubernetes-dashboard-kong-proxy 8443:443

kubectl -n kubernetes-dashboard get pods

#kubectl -n kubernetes-dashboard get all
#kubectl get pods -A -owide
