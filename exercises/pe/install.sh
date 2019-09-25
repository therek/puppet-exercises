#! /usr/bin/env bash

setenforce 0
curl http://127.0.0.1/puppet-enterprise-2019.1.1-el-7-x86_64.tar -o /vagrant/puppet-enterprise-2019.1.1-el-7-x86_64.tar
tar -xvf /vagrant/puppet-enterprise-2019.1.1-el-7-x86_64.tar -C /opt
hostname `curl -s ifconfig.co/json | python -c 'import sys, json; print json.load(sys.stdin)["hostname"]'`
yum -y install tmux tree
