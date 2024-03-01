#!/bin/bash
sudo systemctl disable --now ufw
sudo apt update
sudo apt install nfs-common open-iscsi -y
sudo apt upgrade -y
sudo apt autoremove -y
sudo apt autoremove -y
sudo sh -c 'curl -sfL https://get.rke2.io | INSTALL_RKE2_TYPE=server sh -'
sudo systemctl enable rke2-server.service
sudo systemctl start rke2-server.service
sudo ln -s $(find /var/lib/rancher/rke2/data/ -name kubectl) /usr/local/bin/kubectl
sudo chown reggiej3939:reggiej3939 /etc/rancher/rke2/rke2.yaml 
echo "export KUBECONFIG=/etc/rancher/rke2/rke2.yaml" >> .bashrc
echo 'Please execute "source ~/.bashrc" or log out and back in for changes to take effect.'
sudo cat /var/lib/rancher/rke2/server/node-token