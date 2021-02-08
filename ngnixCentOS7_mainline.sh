#!/bin/bash
set -e

sudo yum install yum-utils -y
sudo cat > /etc/yum.repos.d/nginx.repo << EOL
[nginx-mainline]
name=nginx mainline repo
baseurl=http://nginx.org/packages/mainline/centos/7/x86_64/
gpgcheck=1
enabled=0
gpgkey=https://nginx.org/keys/nginx_signing.key
module_hotfixes=true
EOL
# default: stable, uncomment for mainline
# sudo yum-config-manager --enable nginx-mainline
sudo yum install nginx -y


sudo firewall-cmd --permanent --zone=public --add-service=http 
sudo firewall-cmd --permanent --zone=public --add-service=https
sudo firewall-cmd --reload

sudo systemctl start nginx
sudo systemctl enable nginx
