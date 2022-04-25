#!/bin/bash

sudo apt-get remove docker docker-engine docker.io containerd runc -y

sudo apt update
sudo apt install -y docker.io



# solves issue with kubelet
# More details at https://stackoverflow.com/questions/52119985/kubeadm-init-shows-kubelet-isnt-running-or-healthy

cat <<EOF | sudo tee /etc/docker/daemon.json
{
    "exec-opts": ["native.cgroupdriver=systemd"]
}
EOF

sudo systemctl daemon-reload
sudo systemctl restart docker.service
sudo systemctl enable docker.service

# post installation steps

sudo groupadd docker
sudo chmod 666 /var/run/docker.sock
sudo usermod -aG docker "$USER"
