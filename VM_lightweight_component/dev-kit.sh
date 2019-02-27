#!/bin/bash
rpm -ivh https://yum.puppetlabs.com/puppet5/puppet5-release-el-7.noarch.rpm
yum -y --disablerepo=cern,el7,epel install puppet-agent
yum -y install openssh-server openssh-clients vim-enhanced nfs-utils

systemctl disable firewalld
systemctl stop firewalld
setenforce 0

echo "NFS mount puppet module to /simple_grid"
mkdir /simple_grid
if mount | grep /simple_grid > /dev/null; then
    echo "puppet module is already mounted"
else
    mount -t nfs -o  resvport,rw simple-cm:/simple_grid /simple_grid/
fi

echo "************************* "
echo " Basic packages installed "
echo "************************* "

echo " Installing modules for Production environment (Install stage for Config Master)"
/opt/puppetlabs/bin/puppet module install puppetlabs-docker --version 3.3.0
/opt/puppetlabs/bin/puppet module install puppet-r10k --version 6.8.0 --debug
/opt/puppetlabs/bin/puppet module install puppetlabs-git --version 0.5.0
/opt/puppetlabs/bin/puppet module install puppetlabs-vcsrepo --version 2.4.0
/opt/puppetlabs/bin/puppet module install puppet-python --version 2.1.1
/opt/puppetlabs/bin/puppet module install stahnma-epel --version 1.3.1
/opt/puppetlabs/bin/puppet module install puppet-ssh_keygen --version 3.0.1
/opt/puppetlabs/bin/puppet module install puppetlabs-ruby_task_helper
/opt/puppetlabs/bin/puppet module install puppetlabs-firewall --version 1.15.0
/opt/puppetlabs/bin/puppet module install CERNOps-cvmfs --version 6.0.0

echo "Installing puppet module..."
mkdir -p /etc/puppetlabs/code/environments/production/modules/simple_grid
if mount | grep /etc/puppetlabs/code/environments/production/modules/simple_grid; then
    echo "puppet module is already mounted in the production environment"
else
    mount --bind /simple_grid /etc/puppetlabs/code/environments/production/modules/simple_grid
fi