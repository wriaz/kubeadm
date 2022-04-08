#!/bin/bash

cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
br_netfilter
EOF

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sudo sysctl --system

sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo swapoff -a
sudo apt-get install -y kubectl kubeadm kubectl kubernetes-cni 
sudo apt-mark hold kubelet kubeadm kubectl 

echo 'source <(kubectl completion bash)' >>~/.bashrc
echo 'alias k=kubectl' >>~/.bashrc
echo 'complete -F __start_kubectl k' >>~/.bashrc

kubectl taint node master  node-role.kubernetes.io/master:NoSchedule-
KUBE_FLANNEL_FILE=/tmp/kube-flannel.yml
if test -f "$KUBE_FLANNEL_FILE"; then
    echo "$KUBE_FLANNEL_FILE exists."
    kubectl apply -f $KUBE_FLANNEL_FILE
else 
    echo "$KUBE_FLANNEL_FILE does not exists"
    wget  https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
    kubectl apply -f $KUBE_FLANNEL_FILE
fi


KUBE_INGRESS_FILE=/tmp/deploy.yml
if test -f "$KUBE_INGRESS_FILE"; then
    echo "$KUBE_INGRESS_FILE exists."
    kubectl apply -f $KUBE_INGRESS_FILE
else
    echo "$KUBE_INGRESS_FILE does not exists"
    wget https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.1.1/deploy/static/provider/cloud/deploy.yaml -O $KUBE_INGRESS_FILE
    kubectl apply -f $KUBE_FLANNEL_FILE
fi

