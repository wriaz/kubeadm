#!/bin/bash 

sudo kubeadm init --pod-network-cidr=10.244.0.0/16

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl taint node master  node-role.kubernetes.io/master:NoSchedule-



#kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.1.1/deploy/static/provider/cloud/deploy.yaml

KUBE_FLANNEL_FILE=/tmp/kube-flannel.yml
if test -f "$KUBE_FLANNEL_FILE"; then
    echo "$KUBE_FLANNEL_FILE exists."
    kubectl apply -f $KUBE_FLANNEL_FILE
else
    echo "$KUBE_FLANNEL_FILE does not exists"
    wget  https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml -O $KUBE_FLANNEL_FILE
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

#kubectl apply -f $HOME/kube-flannel.yml
#kubectl apply -f $HOME/ingress/deploy.yaml
