#!/bin/bash

cp /data/puppetserver /etc/sysconfig/puppetserver
cp /data/puppet.conf /etc/puppetlabs/puppet/puppet.conf

hostnamectl set-hostname config_master.cern.ch
hostnamectl set-hostname config_master.cern.ch

echo "Creating symlinks for puppet module"
cp -r --symbolic-link /simple_grid/* /etc/puppetlabs/code/environments/install/site/simple_grid/
cp -r --symbolic-link /simple_grid /etc/puppetlabs/code/environments/config/site/simple_grid/
cp -r --symbolic-link /simple_grid /etc/puppetlabs/code/environments/pre_deploy/site/simple_grid/
cp -r --symbolic-link /simple_grid /etc/puppetlabs/code/environments/deploy/site/simple_grid/
cp -r --symbolic-link /simple_grid /etc/puppetlabs/code/environments/test/site/simple_grid/
cp -r --symbolic-link /simple_grid /etc/puppetlabs/code/environments/cleanup/site/simple_grid/
echo "Starting Puppet Server"
#systemctl start puppetserver
echo "All Set for development"