#!/bin/bash

# growing the /home volume for terraform purpose
growpart /dev/nvme0n1 4
lvextend -L +30G /dev/mapper/RootVG-homeVol
xfs_growfs /home

sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo yum -y install terraform

#install Grafana
wget -q -O gpg.key https://rpm.grafana.com/gpg.key
sudo rpm --import gpg.key
cp repo /etc/yum.repos.d/grafana.repo
sudo dnf install grafana-enterprise
