#!/bin/bash

#https://192.168.29.131:30779

clear

echo "portainer takes time ..wait for few min.. "
export NODE_PORT=$(kubectl get --namespace portainer -o jsonpath="{.spec.ports[1].nodePort}" services portainer)
	  export NODE_IP=$(kubectl get nodes --namespace portainer -o jsonpath="{.items[0].status.addresses[0].address}")
	  echo https://$NODE_IP:$NODE_PORT
	
	

