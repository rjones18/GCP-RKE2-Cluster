#!/bin/bash
sudo systemctl disable --now ufw
sudo apt update
sudo apt install nfs-common open-iscsi -y
sudo apt upgrade -y
sudo apt autoremove -y
sudo apt autoremove -y
sudo sh -c 'curl -sfL https://get.rke2.io | INSTALL_RKE2_TYPE=agent sh -'
sudo mkdir -p /etc/rancher/rke2/
sudo touch /etc/rancher/rke2/config.yaml
sudo cat <<"EOF" > /etc/rancher/rke2/config.yaml
server: https://10.128.0.22:9345
token: #replace with token
EOF
sudo systemctl enable rke2-agent.service
sudo systemctl start rke2-agent.service