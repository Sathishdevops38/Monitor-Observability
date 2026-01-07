#!/bin/bash

# growing the /home volume for terraform purpose
growpart /dev/nvme0n1 4
lvextend -L +30G /dev/mapper/RootVG-homeVol
xfs_growfs /home

# sudo yum install -y yum-utils
# sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
# sudo yum -y install terraform

#install Grafana
sudo yum install -y https://dl.grafana.com/grafana/release/12.3.1/grafana_12.3.1_20271043721_linux_amd64.rpm
sudo systemctl start grafana-server
sudo systemctl enable grafana-server