
#https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/upgrading-linux-nodes/


sudo apt-mark unhold kubeadm && \
sudo apt-get update && sudo apt-get install -y kubeadm='1.31.x-*' && \
sudo apt-mark hold kubeadm

#For worker nodes this upgrades the local kubelet configuration:

#sudo kubeadm upgrade node


# replace x in 1.31.x-* with the latest patch version
sudo apt-mark unhold kubelet kubectl && \
sudo apt-get update && sudo apt-get install -y kubelet='1.31.x-*' kubectl='1.31.x-*' && \
sudo apt-mark hold kubelet kubectl


#Uncordon the node
#Bring the node back online by marking it schedulable:

# execute this command on a control plane node
# replace <node-to-uncordon> with the name of your node
kubectl uncordon <node-to-uncordon>


