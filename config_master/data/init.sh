#!/bin/bash
INSTALL_ENV_DIR=/etc/puppetlabs/code/environments/install
CONFIG_ENV_DIR=/etc/puppetlabs/code/environments/config
PRE_DEPLOY_ENV_DIR=/etc/puppetlabs/code/environments/pre_deploy
DEPLOY_ENV_DIR=/etc/puppetlabs/code/environments/deploy
TEST_ENV_DIR=/etc/puppetlabs/code/environments/test
CLEANUP_ENV_DIR=/etc/puppetlabs/code/environments/cleanup

cp /data/puppetserver /etc/sysconfig/puppetserver
cp /data/puppet.conf /etc/puppetlabs/puppet/puppet.conf
cp -r /data/.puppetlabs /root/

hostnamectl set-hostname config_master.cern.ch
hostnamectl set-hostname config_master.cern.ch

echo "Creating mount points for puppet module"
mount --bind /simple_grid $INSTALL_ENV_DIR/site/simple_grid
mount --bind /simple_grid $CONFIG_ENV_DIR/site/simple_grid
mount --bind /simple_grid $PRE_DEPLOY_ENV_DIR/site/simple_grid
mount --bind /simple_grid $DEPLOY_ENV_DIR/site/simple_grid
mount --bind /simple_grid $TEST_ENV_DIR/site/simple_grid
mount --bind /simple_grid $CLEANUP_ENV_DIR/site/simple_grid


source /etc/profile.d/rvm.sh
echo "Downloading dependencies for install environment"
r10k puppetfile install --puppetfile=$INSTALL_ENV_DIR/Puppetfile
echo "Downloading dependencies for config environment"
r10k puppetfile install --puppetfile=$CONFIG_ENV_DIR/Puppetfile
echo "Downloading dependencies for pre_deploy environment"
r10k puppetfile install --puppetfile=$PRE_DEPLOY_ENV_DIR/Puppetfile
echo "Downloading dependencies for deploy environment"
r10k puppetfile install --puppetfile=$DEPLOY_ENV_DIR/Puppetfile
echo "Downloading dependencies for test environment"
r10k puppetfile install --puppetfile=$TEST_ENV_DIR/Puppetfile
echo "Downloading dependencies for cleanup environment"
r10k puppetfile install --puppetfile=$CLEANUP_ENV_DIR/Puppetfile

echo "Starting Puppet Server"
systemctl start puppetserver
echo "All Set for development"