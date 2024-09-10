#!/bin/sh


##disable ipv6 as most time not required
sysctl -w net.ipv6.conf.all.disable_ipv6=1 1>/dev/null
sysctl -w net.ipv6.conf.default.disable_ipv6=1 1>/dev/null

systemctl stop ufw
systemctl disable ufw


## centos like bash ..for all inteactive 
echo "" >> /etc/bash.bashrc
echo "alias cp='cp -i'" >> /etc/bash.bashrc
echo "alias l.='ls -d .* --color=auto'" >> /etc/bash.bashrc
echo "alias ll='ls -l --color=auto'" >> /etc/bash.bashrc
echo "alias ls='ls --color=auto'" >> /etc/bash.bashrc
echo "alias mv='mv -i'" >> /etc/bash.bashrc
echo "alias rm='rm -i'" >> /etc/bash.bashrc
echo "export EDITOR=vi" >> /etc/bash.bashrc
echo "export LC_CTYPE=en_US.UTF-8" >> /etc/bash.bashrc
echo "export LC_ALL=en_US.UTF-8" >> /etc/bash.bashrc
echo "export LANGUAGE=en_US.UTF-8" >> /etc/bash.bashrc
#echo "export KUBECONFIG=\"/etc/kubernetes/admin.conf\"" >> /etc/bash.bashrc

## setting up rc.local like autoexe.bat for some process to start at end of boot
##backup in case there
/bin/cp -pR /etc/rc.local /opt/old-config-backup/old-rc.local-`date +%s` 1>/dev/null 2>/dev/null
## create with default IPV6 disabledi and other option forced
touch /etc/rc.local
printf '%s\n' '#!/bin/bash'  | tee -a /etc/rc.local 1>/dev/null
echo "sysctl -w net.ipv6.conf.all.disable_ipv6=1" >>/etc/rc.local
echo "sysctl -w net.ipv6.conf.default.disable_ipv6=1" >> /etc/rc.local
echo "sysctl vm.swappiness=0" >> /etc/rc.local
echo "swapoff -a" >> /etc/rc.local
echo "modprobe overlay" >> /etc/rc.local
echo "modprobe br_netfilter" >> /etc/rc.local
echo "sysctl -w net.ipv4.ip_forward=1" >> /etc/rc.local
echo "exit 0" >> /etc/rc.local
chmod 755 /etc/rc.local

## need like autoexe bat on startup to use in some case  like old days for the VM or baremetal
echo "[Unit]" > /etc/systemd/system/rc-local.service
echo " Description=/etc/rc.local Compatibility" >> /etc/systemd/system/rc-local.service
echo " ConditionPathExists=/etc/rc.local" >> /etc/systemd/system/rc-local.service
echo "" >> /etc/systemd/system/rc-local.service
echo "[Service]" >> /etc/systemd/system/rc-local.service
echo " Type=forking" >> /etc/systemd/system/rc-local.service
echo " ExecStart=/etc/rc.local start" >> /etc/systemd/system/rc-local.service
echo " TimeoutSec=0" >> /etc/systemd/system/rc-local.service
echo " StandardOutput=tty" >> /etc/systemd/system/rc-local.service
echo " RemainAfterExit=yes" >> /etc/systemd/system/rc-local.service
## featured Removed
###echo " SysVStartPriority=99" >> /etc/systemd/system/rc-local.service
echo "" >> /etc/systemd/system/rc-local.service
echo "[Install]" >> /etc/systemd/system/rc-local.service
echo " WantedBy=multi-user.target" >> /etc/systemd/system/rc-local.service

systemctl enable rc-local
systemctl start rc-local

## for k8s setup tunning.
#https://kubernetes.io/docs/setup/production-environment/container-runtimes/#cri-o
#Kubernetes requires the following configurations be set before using cri-o container runtime

modprobe overlay
modprobe br_netfilter
cat > /etc/sysctl.d/99-kubernetes-cri.conf <<EOF
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

sysctl --system


## journald rate limit
sed -i "s/#RateLimitIntervalSec=30s/RateLimitIntervalSec=0/"  /etc/systemd/journald.conf
sed -i "s/#RateLimitBurst=10000/RateLimitBurst=0/"  /etc/systemd/journald.conf
systemctl restart systemd-journald
systemctl daemon-reload

## make cpan auto yes for pre-requist modules of perl -- incase used
(echo y;echo o conf prerequisites_policy follow;echo o conf commit)|cpan 1>/dev/null

#Disable vim automatic visual mode using mouse
echo "\"set mouse=a/g" >  ~/.vimrc
echo "syntax on" >> ~/.vimrc
##  for  other new users
echo "\"set mouse=a/g" >  /etc/skel/.vimrc
echo "syntax on" >> /etc/skel/.vimrc

## for Routing
sed -i "s/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g" /etc/sysctl.conf 


##Comment this if you do not want root login via ssh activated using port 7722
#sed -i "s/#PermitRootLogin prohibit-password/PermitRootLogin yes/g" /etc/ssh/sshd_config
#sed -i "s/#Port 22/Port 7722/g" /etc/ssh/sshd_config
#systemctl restart ssh


apt update
apt -y autoremove
apt -y  upgrade
apt -y  dist-upgrade

## install basic postfix, chrony time-server tool instead of default and other useful tools

## postfix for system alert is need , and other basic packages with addon tools for management
CFG_HOSTNAME_FQDN=`hostname -f`
echo "postfix postfix/main_mailer_type select Internet Site" | debconf-set-selections
echo "postfix postfix/mailname string $CFG_HOSTNAME_FQDN" | debconf-set-selections
echo "iptables-persistent iptables-persistent/autosave_v4 boolean true" | debconf-set-selections
echo "iptables-persistent iptables-persistent/autosave_v6 boolean true" | debconf-set-selections
DEBIAN_FRONTEND=noninteractive
apt -y  install vim chrony openssh-server screen net-tools git mc postfix sendemail tmux  \
	sudo wget curl ethtool iptraf-ng traceroute telnet rsyslog software-properties-common \
	dirmngr parted gdisk apt-transport-https lsb-release ca-certificates iputils-ping \
	bridge-utils iptables jq conntrack gnupg nfs-common socat ipset containerd \
	rsyslog-kubernetes kubetail kubecolor 
 
sed -i '/swap/s/^/#/' /etc/fstab
swapoff -a
sysctl -w net.ipv4.ip_forward=1

echo ""
echo ""
echo "---------------------------------------------------------"
echo "Reboot to load kernel update if any and swapoff for k8s"
echo "---------------------------------------------------------"
echo ""
echo ""
