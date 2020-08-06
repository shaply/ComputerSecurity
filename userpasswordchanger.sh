#!/bin/bash

#Download needed stuff
apt-get upgrade
apt-get update
apt-get vim
apt install python3

#Edit user passwords
USERS=$(getent passwd {1000..6000} | cut -d: -f1)
apt install whois
EncryptedPassword=$(mkpasswd -m sha-512 T3@m_C7Ickb@it)
for USER in $USERS; do
usermod -p $EncryptedPassword $USER ;
done

#https://github.com/Forty-Bot/linux-checklist   number 7
sudo ufw enable
sysctl -n net.ipv4.tcp_syncookies
echo "net.ipv6.conf.all.disable_ipv6 = 1" | sudo tee -a /etc/sysctl.conf
echo 0 | sudo tee /proc/sys/net/ipv4/ip_forward
echo "nospoof on" | sudo tee -a /etc/host.conf
sudo apt-get update
sudo apt-get upgrade
