#! /usr/bin/env bash

setenforce 0

# generic settings
yum -y install https://yum.puppet.com/puppet6/puppet6-release-el-7.noarch.rpm
yum -y install puppet-agent git tree telnet vim-enhanced yum-utils device-mapper-persistent-data lvm2

# docker
yum-config-manager --enable rhui-REGION-rhel-server-extras
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum -y install docker-ce docker-ce-cli containerd.io
systemctl enable docker
systemctl start docker
usermod -aG docker ec2-user

# docker-compose
curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# fetch puppet examples
git clone https://github.com/puppetlabs/puppet-in-docker-examples.git
chown -R ec2-user:ec2-user puppet-in-docker-examples

# fetch docker images
cd puppet-in-docker-examples/compose
sed -i -e 's/8140/8140:8140/' docker-compose.yml
/usr/local/bin/docker-compose pull

# prep the puppet infrastruture
hostname=`curl -s ifconfig.co/json | python -c 'import sys, json; print json.load(sys.stdin)["hostname"]'`
/usr/local/bin/docker-compose run puppet ca setup --certname puppet.$(hostname -d) --subject-alt-names puppet,$hostname
echo '127.0.0.1 puppet' >> /etc/hosts
