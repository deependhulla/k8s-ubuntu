#!/bin/bash

cd /tmp

curl -sfL https://get.k3s.io | sh -

echo "Please Wait the pods are getting download, will take few min, around 1.5GB and Created..."
sleep 30
kubectl get pods -A
echo "Please Wait the pods are getting Created..."
sleep 30 
kubectl get pods -A
kubectl get services

echo "Recheck status using : kubectl get pods -A"
cd -
