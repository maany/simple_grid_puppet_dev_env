#!/bin/bash
cp /data/puppet.conf /etc/puppetlabs/puppet/puppet.conf
hostname lightweight_component01.cern.ch
systemctl restart puppet
puppet agent -t