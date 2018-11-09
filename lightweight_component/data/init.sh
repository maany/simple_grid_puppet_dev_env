#!/bin/bash
cp /data/puppet.conf /etc/puppetlabs/puppet/puppet.conf
hostnamectl set-hostname lightweight_component01.cern.ch
hostnamectl set-hostname lightweight_component01.cern.ch
systemctl restart puppet
puppet agent -t