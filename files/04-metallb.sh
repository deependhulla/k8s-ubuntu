
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml


#kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.14.8/config/manifests/metallb-native.yaml
#
helm repo add metallb https://metallb.github.io/metallb
helm install metallb metallb/metallb

#helm install metallb metallb/metallb -f values.yaml

