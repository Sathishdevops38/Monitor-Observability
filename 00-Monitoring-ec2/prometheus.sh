#!/bin/bash

# growing the /home volume for terraform purpose
growpart /dev/nvme0n1 4
lvextend -L +30G /dev/mapper/RootVG-homeVol
xfs_growfs /home

# 1. Create a dedicated system user
sudo useradd --no-create-home --shell /bin/false prometheus
sudo mkdir /etc/prometheus /var/lib/prometheus

# 2. Download and install Prometheus
PROMETHEUS_VERSION="2.51.2" # Use the latest stable version
wget https://github.com/prometheus/prometheus/releases/download/v${PROMETHEUS_VERSION}/prometheus-${PROMETHEUS_VERSION}.linux-amd64.tar.gz
tar -xvf prometheus-${PROMETHEUS_VERSION}.linux-amd64.tar.gz
cd prometheus-${PROMETHEUS_VERSION}.linux-amd64

# 3. Move binaries and set permissions
sudo mv prometheus promtool /usr/local/bin/
sudo mv consoles/ console_libraries/ /etc/prometheus/
sudo mv prometheus.yml /etc/prometheus/prometheus.yml
sudo chown -R prometheus:prometheus /etc/prometheus /var/lib/prometheus


sudo cp ./prometheus.repo /etc/systemd/system/prometheus.service
sudo systemctl daemon-reload
sudo systemctl enable --now prometheus