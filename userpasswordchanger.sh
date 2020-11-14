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

#Debian Script Stuff
echo "Debian Script Stuff edit password policies"
apt-get install libpam-cracklib -y -qq
cp /etc/pam.d/common-auth ~/Desktop/backups/
cp /etc/pam.d/common-password ~/Desktop/backups/
grep "auth optional pam_tally.so deny=5 unlock_time=900 onerr=fail audit even_deny_root_account silent " /etc/pam.d/common-auth
if [ "$?" -eq "1" ]
then	
	echo "auth optional pam_tally.so deny=5 unlock_time=900 onerr=fail audit even_deny_root_account silent " >> /etc/pam.d/common-auth
	echo -e "password requisite pam_cracklib.so retry=3 minlen=8 difok=3 reject_username minclass=3 maxrepeat=2 dcredit=1 ucredit=1 lcredit=1 ocredit=1\npassword requisite pam_pwhistory.so use_authtok remember=24 enforce_for_root" >>  /etc/pam.d/common-password
fi
echo "Password policies have been set, editing /etc/login.defs and pam.d."

echo "Debian Script Stuff remove hacking stuff (reinstall netcat)"
apt-get purge netcat -y -qq
apt-get purge netcat-openbsd -y -qq
apt-get purge netcat-traditional -y -qq
apt-get purge ncat -y -qq
apt-get purge pnetcat -y -qq
apt-get purge socat -y -qq
apt-get purge sock -y -qq
apt-get purge socket -y -qq
apt-get purge sbd -y -qq
rm /usr/bin/nc
clear
echo "Netcat and all other instances have been removed."

apt-get purge john -y -qq
apt-get purge john-data -y -qq
clear
echo "John the Ripper has been removed."

apt-get purge hydra -y -qq
apt-get purge hydra-gtk -y -qq
clear
echo "Hydra has been removed."

apt-get purge aircrack-ng -y -qq
clear
echo "Aircrack-NG has been removed."

apt-get purge fcrackzip -y -qq
clear
echo "FCrackZIP has been removed."

apt-get purge lcrack -y -qq
clear
echo "LCrack has been removed."

apt-get purge ophcrack -y -qq
apt-get purge ophcrack-cli -y -qq
clear
echo "OphCrack has been removed."

apt-get purge pdfcrack -y -qq
clear
echo "PDFCrack has been removed."

apt-get purge pyrit -y -qq
clear
echo "Pyrit has been removed."

apt-get purge rarcrack -y -qq
clear
echo "RARCrack has been removed."

apt-get purge sipcrack -y -qq
clear
echo "SipCrack has been removed."

apt-get purge irpas -y -qq
clear
echo "IRPAS has been removed."

#https://github.com/Forty-Bot/linux-checklist   number 7
echo "ufw enable"
sudo ufw enable
sysctl -n net.ipv4.tcp_syncookies
echo "net.ipv6.conf.all.disable_ipv6 = 1" | sudo tee -a /etc/sysctl.conf
echo 0 | sudo tee /proc/sys/net/ipv4/ip_forward
echo "nospoof on" | sudo tee -a /etc/host.conf
sudo apt-get update
sudo apt-get upgrade

#Debian Script Stuff 
echo "Debian Script Stuff Update Upgrade"
chmod 777 /etc/apt/apt.conf.d/10periodic
cp /etc/apt/apt.conf.d/10periodic ~/Desktop/backups/
echo -e "APT::Periodic::Update-Package-Lists \"1\";\nAPT::Periodic::Download-Upgradeable-Packages \"1\";\nAPT::Periodic::AutocleanInterval \"1\";\nAPT::Periodic::Unattended-Upgrade \"1\";" > /etc/apt/apt.conf.d/10periodic
chmod 644 /etc/apt/apt.conf.d/10periodic
echo "Daily update checks, download upgradeable packages, autoclean interval, and unattended upgrade enabled."

echo "visudo -cf /etc/sudoers"
visudo -cf /etc/sudoers

echo "find media files"
find /home -iname "*.mp3" -print
find /home -iname "*.mp4" -print
find /home -iname "*.wav" -print
