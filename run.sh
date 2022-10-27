#!/bin/bash 
set -e

VERIFIED_OS="Ubuntu 20.04"
GREEN='\033[0;32m'
RED='\033[0;31m'
RESET='\033[0m'
 

VERIFIED_OS="Ubuntu 20.04"

install_kubeadm(){
    echo -e "\n \n"
    echo -e "${GREEN}Starting Installation${RESET}"
    echo -e "\n \n"
    sleep 3

    echo -e "${GREEN}Installing Docker!!${RESET}"
    echo -e "\n \n"
    if [[ which docker && docker --version ]]; then
        echo -e "${GREEN}Docker already installed. Skipping Installation\n${RESET}"
      # command
    else
      echo "Install docker"
      sleep 3
      ./install-docker.sh
    fi

    echo -e "${GREEN}Installing Kubeadm!!${RESET}"
    echo -e "\n \n"
    sleep 3
    ./install-kubeadm.sh

    echo -e "${GREEN}Starting Kubeadm${RESET}"
    echo -e "\n \n"
    sleep 3
    ./start-kubeadm.sh

    echo -e "${GREEN}Installing Helm${RESET}"
    echo -e "\n \n"
    sleep 3
    ./install-helm.sh

    echo -e "\n \n"
    echo -e "${GREEN}Installation Complete!${RESET}"
    echo -e "\n \n"
}

 
if [[ $(lsb_release -rs) == "20.04" ]]; then 
    echo -e "${GREEN}Compatible version of OS for this script${RESET}"
    echo -e "\n \n"
    install_kubeadm
    
else
    echo -e "${RED}This script is only verified with "$VERIFIED_OS". Do you still want to continue (y/n)?${RESET}"
read answer
    if [ "$answer" != "${answer#[Yy]}" ] ;then
        install_kubeadm
    else
        echo -e "Exiting without Installation" 
        exit 0
    fi  
fi
