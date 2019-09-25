#!/usr/bin/env sh

[[ ! `vagrant plugin list | grep vagrant-aws` ]] && vagrant plugin install vagrant-aws || echo "Skipping install of vagrant-aws plugin"
[[ ! `vagrant box list | grep dummy` ]] && vagrant box add dummy https://github.com/mitchellh/vagrant-aws/raw/master/dummy.box \
  || echo "Skipping download of AWS dummy box"

