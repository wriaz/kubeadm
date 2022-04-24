#!/bin/bash

set -x

sudo kubeadm reset
rm -rf /etc/cni/
sudo rm -rf /etc/cni/* 
sudo ipvsadm --clear 
sudo rm -rf ~/.kube/
sudo systemctl stop kubelet 
sudo systemctl stop docker 
sudo rm -rf /var/lib/cni/
sudo rm -rf /var/lib/kubelet/* 
sudo rm -rf /etc/cni/
ifconfig cni0 down 
sudo ifconfig cni0 down 
sudo ifconfig docker0 down 
umount /var/lib/kubelet 
ip link set cni0 down 
sudo ip link set cni0 down 
sudo brctl delbr cni0 
sudo ip link delete cni0 
sudo ip link delete flannel.1 
sudo systemctl restart conainerd && systemctl restart kubelet 
sudo systemctl restart containerd && sudo systemctl restart kubelet 
