#!/bin/bash

# growing the /home volume for terraform purpose
growpart /dev/nvme0n1 4
lvextend -L +30G /dev/mapper/RootVG-homeVol
xfs_growfs /home

sudo wget https://github.com/prometheus/prometheus/rel                                                                       eases/download/v3.9.0-rc.0/prometheus-3.9.0-rc.0.linux-amd64.tar.gz
sudo tar -xzvf prometheus-3.9.0-rc.0.linux-amd64.tar.gz
rm -rf prometheus-3.9.0-rc.0.linux-amd64.tar.gz
sudo rm -rf prometheus-3.9.0-rc.0.linux-amd64.tar.gz
cd prometheus-3.9.0-rc.0.linux-amd64/
sudo groupadd --system prometheus
cat /etc/group
sudo useradd -s /sbin/nologin --system -g prometheus prometheus
cat /etc/group
sudo mkdir /var/lib/prometheus
sudo mkdir -p /etc/prometheus/rules
sudo mkdir -p /etc/prometheus/rules.s
sudo mkdir -p /etc/prometheus/files_sd
cd prometheus-3.9.0-rc.0.linux-amd64/
sudo mv prometheus promtool /usr/local/bin
prometheus --version
sudo mv prometheus.yml /etc/prometheus/prometheus.yml
sudo tee /etc/systemd/system/prometheus.service<<EOF
[Unit]
Description=Prometheus
Documentation=https://prometheus.io/docs/introduction/overview/
Wants=network-online.target
After=network-online.target

[Service]
Type=simple
User=prometheus
Group=prometheus
ExecReload=/bin/kill -HUP $MAINPID
ExecStart=/usr/local/bin/prometheus   --config.file=/etc/prometheus/prometheus.yml   
--storage.tsdb.path=/var/lib/prometheus   --web.console.templates=/etc/pr                                                                          ometheus/consoles   --web.console.libraries=/etc/prometheus/console_libraries                                                                             --web.listen-address=0.0.0.0:9090   --web.external-url=

SyslogIdentifier=prometheus
Restart=always

[Install]
WantedBy=multi-user.target
EOF
sudo chown -R prometheus:prometheus /etc/prometheus/
sudo chown -R prometheus:prometheus /etc/prometheus/*
sudo chmod -R 775 /etc/prometheus/
sudo chmod -R 775 /var/lib/prometheus/
sudo chown -R prometheus:prometheus /var/lib/prometheus/
sudo systemctl daemon-reload
sudo systemctl start prometheus
sudo systemctl status prometheus