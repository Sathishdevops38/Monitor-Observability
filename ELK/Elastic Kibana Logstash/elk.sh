#!/bin/bash
LOG=/var/log/setup-summary.log
sudo growpart /dev/nvme0n1 4
sudo lvextend -L +20G /dev/RootVG/rootVol
sudo lvextend -L +20G /dev/RootVG/varVol
sudo xfs_growfs /
sudo xfs_growfs /var

sudo tee /etc/yum.repos.d/elasticsearch.repo<<EOF
[elasticsearch]
name=Elasticsearch repository for 9.x packages
baseurl=https://artifacts.elastic.co/packages/9.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
type=rpm-md
EOF
sudo dnf install elasticsearch kibana logstash nginx -y
sudo systemctl start elasticsearch
sudo systemctl start kibana
sudo systemctl enable elasticsearch
sudo systemctl enable kibana
sudo systemctl start nginx
sudo cp nginx.repo /etc/nginx/nginx.conf
sudo systemctl restart nginx 
#Generate an enrollment token for Kibana instance.
/usr/share/elasticsearch/bin/elasticsearch-create-enrollment-token -s kibana >> $LOG 2>&1
#Kibana Verification
/usr/share/kibana/bin/kibana-verification-code >> $LOG 2>&1
#Reset admin password
/usr/share/elasticsearch/bin/elasticsearch-reset-password -u elastic  >> $LOG 2>&1
