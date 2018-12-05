#!/bin/bash
cp /data/puppetserver /etc/sysconfig/puppetserver
cp /data/puppet.conf /etc/puppetlabs/puppet/puppet.conf

hostnamectl set-hostname basic_config_master.cern.ch
hostnamectl set-hostname basic_config_master.cern.ch

echo "Creating mount points for puppet module"
mkdir -p /etc/puppetlabs/code/environments/production/modules/simple_grid
mount --bind /simple_grid /etc/puppetlabs/code/environments/production/modules/simple_grid

echo "All Set for development"