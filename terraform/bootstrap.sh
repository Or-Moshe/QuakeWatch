#!/bin/bash
sudo -i
curl -sfL https://get.k3s.io | sh -s - --write-kubeconfig-mode 644
sudo apt update -y && sudo apt install docker.io -y
yum install docker -y
systemctl enable docker
systemctl start docker


