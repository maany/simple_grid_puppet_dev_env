#!/bin/bash
echo ""
echo "BEFORE RUNNING THIS SCRIPT, make sure you have configured NFS on all of your dev nodes. After that, edit this script to remove exit 0 after these echo commands."
echo "*********************************"
echo " 1. Clone your Simple GRID module:"
echo "*********************************"
echo "git clone https://github.com/<GIT-USERNAME>/simple_grid_puppet_module /etc/puppetlabs/code/environments/production/modules/simple_grid/"
echo ""
echo "*********************************"
echo " Edit /etc/exports with your development machine ip address"
echo "*********************************"
echo " vim /etc/exports"
echo " It would look something like:"
echo "/simple_grid 194.12.159.48(rw,sync,no_subtree_check) simple-lc01.cern.ch(rw,sync,no_subtree_check) simple-lc02.cern.ch(rw,sync,no_subtree_check)"
echo ""
echo "*********************************"
echo " Restart NFS service"
echo "*********************************"
echo ""
echo " systemctl restart nfs-server "
echo ""
echo "*********************************"
echo "To mount in your dev machine: sudo mount -t nfs -o  resvport,rw <CM-MACHINE_IP_ADDRESS>:/etc/puppetlabs/code/environments/production/modules/simple_grid/ <˜YOUR-USER/DIR/>"
echo ""
echo " To run VsCode from your Mac:"
echo ""
echo " sudo /Applications/Visual\ Studio\ Code.app/Contents/MacOS/Electron"
echo ""
exit 0

rpm -ivh https://yum.puppetlabs.com/puppet5/puppet5-release-el-7.noarch.rpm
yum -y --disablerepo=cern,el7,epel install puppetserver puppet-agent puppet-bolt
yum -y install openssh-server openssh-clients vim-enhanced nfs-utils

systemctl disable firewalld
systemctl stop firewalld
setenforce 0

echo "/etc/puppetlabs/code/environments/production/modules/simple_grid/    <DEV-MACHINE-IP-ADDRESS>(rw,sync,no_root_squash,no_all_squash)" >> /etc/exports
echo "************************* "
echo " Basic packages installed "
echo "************************* "

echo "Copying puppet server config"
cp /root/basic_config_master/data/puppetserver /etc/sysconfig/puppetserver

echo "Copying bolt config files to root"
cp -r /root/basic_config_master/data/.puppetlabs /root/

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
if mount | grep /etc/puppetlabs/code/environments/production/modules/simple_grid; then
    echo "puppet module is already mounted in the production environment"
else
    mkdir -p /etc/puppetlabs/code/environments/production/modules/simple_grid
    mount --bind /simple_grid /etc/puppetlabs/code/environments/production/modules/simple_grid
fi

echo "Creating dummy scripts..."
mkdir -p /etc/simple_grid/lifecycle
touch /etc/simple_grid/lifecycle/wn_pre_config.sh
touch /etc/simple_grid/lifecycle/wn_pre_inst1.sh
touch /etc/simple_grid/lifecycle/wn_post_inst1.sh
touch /etc/simple_grid/lifecycle/ce_pre_config.sh
touch /etc/simple_grid/lifecycle/ce_pre_inst1.sh
touch /etc/simple_grid/lifecycle/ce_post_inst1.sh

