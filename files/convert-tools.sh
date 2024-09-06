#!/bin/bash

cd /tmp

#https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#install-using-native-package-management

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl-convert"
   
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl-convert.sha256"
   
sudo install -o root -g root -m 0755 kubectl-convert /usr/local/bin/kubectl-convert


kubectl convert --help


cd -
