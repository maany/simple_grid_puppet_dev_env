#!/bin/bash

cp /data/puppetserver /etc/sysconfig/puppetserver
cp /data/puppet.conf /etc/puppetlabs/puppet/puppet.conf
hostnamectl set-hostname config_master.cern.ch
systemctl start puppetserver