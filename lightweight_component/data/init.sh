#!/bin/bash
#cp /data/puppet.conf /etc/puppetlabs/puppet/puppet.conf

hostnamectl set-hostname $NAME.cern.ch
hostnamectl set-hostname $NAME.cern.ch

echo "Installing puppet module"
mkdir -p /etc/puppetlabs/code/environments/production/modules/simple_grid
mount --bind /simple_grid /etc/puppetlabs/code/environments/production/modules/simple_grid

systemctl restart puppet

#echo "Starting Docker "
#systemctl start docker
echo "Setup SSH"
mkdir ~/.ssh
cp /data/authorized_keys ~/.ssh

echo "Starting rsyslog"
systemctl start rsyslog
#echo "Setting up DinD"
#systemctl start docker
#ln -s /usr/libexec/docker/docker-runc-current /usr/bin/docker-runc
#chmod +x /data/wrapdocker.sh
#/data/wrapdocker.sh
