# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.define "master", primary: true do |master|
    master.vm.provider "virtualbox" do |v|
      v.memory = 3072
    end

    master.vm.box      = "centos/7"
    master.vm.hostname = "master"
    master.vm.network  "private_network", type: "dhcp"

    config.vm.provision 'shell', path: 'scripts/install.sh'
    config.vm.provision "shell", inline: "yum -y install puppetserver"
  end

  config.vm.define "agent1" do |agent|
    agent.vm.provider "virtualbox" do |v|
      v.memory = 1024
    end

    agent.vm.box      = "centos/7"
    agent.vm.hostname = "agent1"
    agent.vm.network  "private_network", type: "dhcp"

    config.vm.provision 'shell', path: 'scripts/install.sh'
    config.vm.provision "shell", inline: "yum -y install puppet-agent"
  end
end
