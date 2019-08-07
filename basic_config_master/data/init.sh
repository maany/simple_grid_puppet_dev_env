#!/bin/bash
cp /data/puppetserver /etc/sysconfig/puppetserver

hostnamectl set-hostname basic_config_master.cern.ch
hostnamectl set-hostname basic_config_master.cern.ch

#echo "Building puppet module"
#puppet module build /simple_grid

echo "Installing puppet module"
mkdir -p /etc/puppetlabs/code/environments/production/modules/simple_grid
mount --bind /simple_grid /etc/puppetlabs/code/environments/production/modules/simple_grid

echo "Configuring Bolt"
cp -r /data/.puppetlabs /root/.puppetlabs

echo "Creating dummy scripts"
mkdir -p /etc/simple_grid/lifecycle
touch /etc/simple_grid/lifecycle/wn_pre_config.sh
touch /etc/simple_grid/lifecycle/wn_pre_inst1.sh
touch /etc/simple_grid/lifecycle/wn_post_inst1.sh
touch /etc/simple_grid/lifecycle/ce_pre_config.sh
touch /etc/simple_grid/lifecycle/ce_pre_inst1.sh
touch /etc/simple_grid/lifecycle/ce_post_inst1.sh

echo "Creating host certificates"
mkdir -p /etc/simple_grid/host_certificates/lightweight_component01.cern.ch
touch /etc/simple_grid/host_certificates/lightweight_component01.cern.ch/hostcert.pem
touch /etc/simple_grid/host_certificates/lightweight_component01.cern.ch/hostkey.pem

echo "Starting Docker service"
systemctl start docker

pip install --upgrade pip setuptools wheel
echo "Install python requirements"
pip install -r /etc/simple_grid/testinfra/simple_grid_infra_validation_engine/requirements.txt
echo "Package and Install Yaml Compiler"
pip install -r /etc/simple_grid/testinfra/simple_grid_yaml_compiler/requirements.txt
mkdir /etc/simple_grid/testinfra/simple_grid_yaml_compiler/.temp
(cd -- /etc/simple_grid/testinfra/simple_grid_yaml_compiler && python setup.py install )
export PYTHONPATH=$PYTHONPATH:/etc/simple_grid/testinfra/simple_grid_yaml_compiler
echo "export PYTHONPATH=$PYTHONPATH:/etc/simple_grid/testinfra/simple_grid_yaml_compiler" >> ~/.bashrc
echo "Starting rsyslog"
systemctl start rsyslog

# echo "Setting up DinD"
# systemctl start docker
# ln -s /usr/libexec/docker/docker-runc-current /usr/bin/docker-runc
# chmod +x /data/wrapdocker.sh
# /data/wrapdocker.sh
echo "All Set for development"
cd /etc/simple_grid/