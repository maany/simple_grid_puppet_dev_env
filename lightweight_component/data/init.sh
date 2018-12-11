#!/bin/bash
#cp /data/puppet.conf /etc/puppetlabs/puppet/puppet.conf

hostnamectl set-hostname lightweight_component01.cern.ch
hostnamectl set-hostname lightweight_component01.cern.ch

echo "Installing puppet module"
mkdir -p /etc/puppetlabs/code/environments/production/modules/simple_grid
mount --bind /simple_grid /etc/puppetlabs/code/environments/production/modules/simple_grid

systemctl restart puppet
#puppet agent -t