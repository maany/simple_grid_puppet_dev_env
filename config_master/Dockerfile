FROM cern/cc7-base
LABEL Maintainer="Mayank Sharma (imptodefeat@gmail.com)"
RUN rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
RUN yum -y install puppetserver puppet-agent

# Directories for puppet environments
RUN mkdir /etc/puppetlabs/code/environments/install
RUN mkdir /etc/puppetlabs/code/environments/config
RUN mkdir /etc/puppetlabs/code/environments/pre_deploy
RUN mkdir /etc/puppetlabs/code/environments/deploy
RUN mkdir /etc/puppetlabs/code/environments/test
RUN mkdir /etc/puppetlabs/code/environments/cleanup

# Volumes for puppet environments
VOLUME ["/etc/puppetlabs/code/environments/install"]
VOLUME ["/etc/puppetlabs/code/environments/config"]
VOLUME ["/etc/puppetlabs/code/environments/pre_deploy"]
VOLUME ["/etc/puppetlabs/code/environments/deploy"]
VOLUME ["/etc/puppetlabs/code/environments/test"]
VOLUME ["/etc/puppetlabs/code/environments/cleanup"]

# Volumes for puppet module inside each environment
VOLUME ["/etc/puppetlabs/code/environments/install/site/simple_grid/"]
VOLUME ["/etc/puppetlabs/code/environments/config/site/simple_grid/"]
VOLUME ["/etc/puppetlabs/code/environments/pre_deploy/site/simple_grid/"]
VOLUME ["/etc/puppetlabs/code/environments/deploy/site/simple_grid/"]
VOLUME ["/etc/puppetlabs/code/environments/test/site/simple_grid/"]
VOLUME ["/etc/puppetlabs/code/environments/cleanup/site/simple_grid/"]

# ENC
RUN mkdir /enc
VOLUME [ "/enc" ]

# Puppetserver config
RUN mkdir /data
VOLUME [ "/data" ]

RUN mkdir /simple_grid_puppet_module
VOLUME [ "/simple_grid_puppet_module" ]

#systemd
ENV container docker
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

VOLUME [ "/sys/fs/cgroup" ]
CMD ["/usr/sbin/init"]