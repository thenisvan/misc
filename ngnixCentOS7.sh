#!/bin/bash


if [ `whoami` != root ]; then
    echo Please run this script as root or using sudo
    exit
fi

yum install epel-release -y
yum install nginx -y

export HOSTNAME=$(hostname)
export PUBLIC_IPV4=$(hostname -I | awk '{ print $1; }' )
echo Droplet: $HOSTNAME, IP Address: $PUBLIC_IPV4 > /usr/share/nginx/html/index.html

systemctl start nginx

firewall-cmd --permanent --zone=public --add-service=http 
firewall-cmd --permanent --zone=public --add-service=https
firewall-cmd --reload

systemctl enable nginx
curl -o /dev/null -s -w "%{http_code}\n" http://$PUBLIC_IPV4
