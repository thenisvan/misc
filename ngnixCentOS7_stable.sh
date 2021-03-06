#!/bin/bash
set -e #break if error occur
sudo yum install yum-utils -y
sudo cat > /etc/yum.repos.d/nginx.repo << EOL
[nginx-stable]
name=nginx stable repo
baseurl=http://nginx.org/packages/centos/7/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://nginx.org/keys/nginx_signing.key
module_hotfixes=true
EOL
sudo yum install nginx -y


sudo firewall-cmd --permanent --zone=public --add-service=http 
sudo firewall-cmd --permanent --zone=public --add-service=https
sudo firewall-cmd --reload

sudo systemctl start nginx
sudo systemctl enable nginx
