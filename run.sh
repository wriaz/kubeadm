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

    echo -e "Installing Docker!!"
    echo -e "\n \n"
    sleep 3
    ./install-docker.sh

    echo -e "Installing Kubeadm!!"
    echo -e "\n \n"
    sleep 3
    ./install-kubeadm.sh

    echo -e "Starting Kubeadm"
    echo -e "\n \n"
    sleep 3
    ./start-kubeadm.sh

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
