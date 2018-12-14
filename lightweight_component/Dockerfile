FROM cern/cc7-base
LABEL Maintainer="Mayank Sharma (imptodefeat@gmail.com)"

#install puppet agent
RUN rpm -ivh https://yum.puppetlabs.com/puppet5/puppet5-release-el-7.noarch.rpm
RUN yum -y --disablerepo=cern,el7,epel install puppet-agent

#install openssh client and server
RUN yum install -y openssh-server openssh-clients net-tools iptables docker 

#make data directory
RUN mkdir /data
VOLUME [ "/data" ]
VOLUME ["/simple_grid"]
VOLUME [ "/var/lib/docker" ]
VOLUME [ "/var/run/docker.sock" ]
#systemd settings
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