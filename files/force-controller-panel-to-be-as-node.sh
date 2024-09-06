

## very important if you run on single pc and got error like pods are pending.

# Exasmple
## Warning  FailedScheduling  3m54s  default-scheduler  0/1 nodes are available: 1 node(s) had untolerated taint {node-role.kubernetes.io/control-plane: }. preemption: 0/1 nodes are available: 1 Preemption is not helpful for scheduling.


#https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/#control-plane-node-isolation


#Control plane node isolation
#By default, your cluster will not schedule Pods on the control plane nodes for security reasons. 
#If you want to be able to schedule Pods on the control plane nodes, for example for a single machine Kubernetes cluster, run:

kubectl taint nodes --all node-role.kubernetes.io/control-plane-
kubectl label nodes --all node.kubernetes.io/exclude-from-external-load-balancers-
