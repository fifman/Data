#!/bin/bash

sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine


sudo yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2


sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

sudo yum -y install docker-ce

sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

#sudo firewall-cmd --add-port=2376/tcp --permanent  
#sudo firewall-cmd --add-port=2377/tcp --permanent  
#sudo firewall-cmd --add-port=7946/tcp --permanent  
#sudo firewall-cmd --add-port=7946/udp --permanent  
#sudo firewall-cmd --add-port=4789/udp --permanent
#sudo systemctl restart firewalld


#停止firewalld服务
systemctl stop firewalld
#禁用firewalld服务
systemctl mask firewalld

yum install -y iptables
yum update iptables
yum install -y iptables-services

systemctl enable iptables.service
systemctl start iptables.service

#暴露docker swarm需要的端口，如果不使用docker swarm不需要打开端口
# 注意，这些规则必须插入，而不是附加在最后。因为必须优先于拒绝规则5之前。
iptables -A INPUT -p tcp --dport 2376 -j ACCEPT
iptables -A INPUT -p udp --dport 2376 -j ACCEPT
iptables -A INPUT -p tcp --dport 2377 -j ACCEPT
iptables -A INPUT -p tcp --dport 7946 -j ACCEPT
iptables -A INPUT -p udp --dport 7946 -j ACCEPT
iptables -A INPUT -p tcp --dport 4789 -j ACCEPT
iptables -A INPUT -p udp --dport 4789 -j ACCEPT

service iptables save
systemctl restart iptables.service

#开启转发
echo 'net.ipv4.ip_forward=1'> /usr/lib/sysctl.d/00-system.conf

systemctl restart network
