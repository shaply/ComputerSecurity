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
