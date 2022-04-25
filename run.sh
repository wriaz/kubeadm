#!/bin/bash 
set -e

VERIFIED_OS="Ubuntu 20.04"
GREEN='\033[0;32m'
RED='\033[0;31m'
RESET='\033[0m'
 

VERIFIED_OS="Ubuntu 20.04"

install_kubeadm(){
    echo "\n \n"
    echo -e "${GREEN}Starting Installation${RESET}"
    echo "\n \n"
    sleep 3

    echo "Installing Docker!!"
    echo "\n \n"
    sleep 3
    ./install-docker.sh

    echo "Installing Kubeadm!!"
    echo "\n \n"
    sleep 3
    ./install-kubeadm.sh

    echo "Starting Kubeadm"
    echo "\n \n"
    sleep 3
    ./start-kubeadm.sh

}

 
if [[ $(lsb_release -rs) == "20.04" ]]; then 
    echo -e "${GREEN}Compatible version of OS for this script${RESET}"
    echo "\n \n"
    install_kubeadm
    
else
    echo -e "${RED}This script is only verified with "$VERIFIED_OS". Do you still want to continue (y/n)?${RESET}"
read answer
    if [ "$answer" != "${answer#[Yy]}" ] ;then
        install_kubeadm
    else
        echo "Exiting without Installation" 
        exit 0
    fi  
fi
