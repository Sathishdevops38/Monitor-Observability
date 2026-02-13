#!/bin/bash
sudo tee /etc/yum.repos.d/elasticsearch.repo<<EOF
[elasticsearch]
name=Elasticsearch repository for 9.x packages
baseurl=https://artifacts.elastic.co/packages/9.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
type=rpm-md
EOF
sudo dnf install filebeat -y
sudo dnf install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx