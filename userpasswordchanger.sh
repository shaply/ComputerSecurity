#!/bin/bash
USERS=$(getent passwd {1000..6000} | cut -d: -f1)
apt install whois
EncryptedPassword=$(mkpasswd -m sha-512 T3@m_C7Ickb@it)
for USER in $USERS; do
usermod -p $EncryptedPassword $USER ;
done
