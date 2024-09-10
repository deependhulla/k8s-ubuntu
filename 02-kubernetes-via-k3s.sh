#!/bin/bash

cd /tmp

curl -sfL https://get.k3s.io | sh -

echo "Please Wait the pods are getting download  arounf 1.5GB and Created..."
sleep 10
kubectl get pods -A
echo "Please Wait the pods are getting Created..."
sleep 20 
kubectl get pods -A
cd -
