
#https://earthly.dev/blog/deploy-kubernetes-cri-o-container-runtime/

kubectl create deploy nginx-web-server --image nginx

#kubectl expose deploy nginx-web-server --port 80 --type NodePort

#kubectl run -it --rm busybox --image busybox

