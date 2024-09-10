#!/bin/bash

cd /tmp
clear
curl -sfL https://get.rke2.io | sh -
systemctl enable rke2-server.service

date
echo "Starting Service...it would download lots of packages...will take 10-15 min"
systemctl start rke2-server.service
# Wait a bit
echo "Wait few more minutes to get it up and ready"
sleep 30
export KUBECONFIG=/etc/rancher/rke2/rke2.yaml PATH=$PATH:/var/lib/rancher/rke2/bin
kubectl get nodes

cd -
