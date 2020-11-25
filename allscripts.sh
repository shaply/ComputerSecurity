#!/bin/bash

echo "Make Sure You have Everything Set. All codes set. Root Set. Everything!"
echo "Linux Ubuntu Script\nThe Ultimate One\nLet's Pray it Works"

read -p "Make Sure you have done the forensics Questions"
read -p "Did you run as root? If not, rerun"

mkdir -p ~/Desktop/backups
chmod 777 ~/Desktop/backups

echo "Creating backups for /etc/group /etc/passwd /etc/login.defs in ~/Desktop/backups"
cp /etc/group ~/Desktop/backups/
cp /etc/passwd ~/Desktop/backups/
cp /etc/login.defs ~/Desktop/backups/

echo "Editting login.defs"
#If you did '160s/.*/PASS_MAX_DAYS\o01130/' The o011 would just mean type a tab
sed -i '160s/.*/PASS_MAX_DAYS\ 30/' /etc/login.defs
sed -i '161s/.*/PASS_MIN_DAYS\ 3/' /etc/login.defs
sed -i '162s/.*/PASS_MIN_LEN\ 8/' /etc/login.defs
sed -i '163s/.*/PASS_WARN_AGE\ 7/' /etc/login.defs
sed -i '279s/.*/ENCRYPT_METHOD\ SHA512/' /etc/login.defs
sed -i '151s/.*/UMASK\ 077/' /etc/login.defs
sed -i '167s/.*/UID_MIN\ 1000/' /etc/login.defs
sed -i '168s/.*/UID_MAX\ 60000/' /etc/login.defs
sed -i '42s/.*/FAILLOG_ENAB\ yes/' /etc/login.defs
sed -i '50s/.*/LOG_UNKFAIL_ENAB\ yes/' /etc/login.defs
sed -i '61s/.*/SYSLOG_SU_ENAB\ yes/' /etc/login.defs
sed -i '62s/.*/SYSLOG_SG_ENAB\ yes/' /etc/login.defs
nums='160 161 162 163 279 151 167 168 42 50 61 62'
for i in $nums; do sed -n $( echo $i )p /etc/login.defs; done
read -p 'Make sure all the lines are correct'
echo "Password policies have been set with /etc/login.defs."

echo "Downloading Python3, Vim, Updates, and stuff"
apt-get upgrade
apt-get update
apt-get install vim
apt install python3
apt-get install python3
read -p "Make sure python3, sed, and vim work, if not manually download"

echo "Changing the Passwords for every team to T3@m_C7Ickb@it"
USERS=$(getent passwd {1000..6000} | cut -d: -f1)
apt install whois
EncryptedPassword=$(mkpasswd -m sha-512 T3@m_C7Ickb@it)
for USER in $USERS; do
usermod -p $EncryptedPassword $USER
passwd -x30 -n3 -w7 ${users[${i}]}
echo "${users[${i}]}'s password has been given a maximum age o
f 30 days, minimum of 3 days, and warning of 7 days. ${users[${i}]}'s account has b
een locked." ;
done

echo "Do you need to add a user, if so type the users account name, other wise type N"
read userYN
while [ $userYN != N ]
do adduser $userYN
echo "$userYN has been created"
echo "Do you want to make $userYN an admin?"
read adminYN
if [ $adminYN == yes ]
then 
gpasswd -a $userYN sudo
gpasswd -a $userYN adm
gpasswd -a $userYN lpadmin
gpasswd -a $userYN sambashare
echo "$userYN is an admin"
else
echo "$userYN is a standard user"
fi
passwd -x30 -n3 -w7 $userYN
usermod -p $EncryptedPassword $USER
echo "$userYN has been set"
echo "Do you need to add a user, if so type the users account name, other wise type
 N"
read userYN
done

read -p "Make sure you have created PCusers.txt with all the users copied in it"
read -p "I REPEAT MAKE THE FILE PCusers.txt with the users copied in it"
cp /etc/group ~/Desktop/backups/
userReader="with|open('PCusers.txt')|as|file: ||allLines=file.read().split('\n') ||admins=[] ||users=[] ||which='administrators'  ||for|row|in|allLines: ||||if|'password'|not|in|row.lower(): ||||||||if|'users'|in|row.lower(): ||||||||||which='users' ||||||||if|which|==|'administrators': ||||||||||if|'|'|in|row: ||||||||||||row=row.split()[0] ||||||||||admins.append(row) ||||||||if|which=='users': ||||||||||users.append(row) ||allusers=admins+users  ||#Doesn't|delete|users|from|sudo|group|yet ||import|os ||os.chdir('/home') ||allUser=os.listdir() ||for|user|in|allUser: ||||if|user|not|in|allusers: ||||||os.system('userdel|%s'%(user))  with|open('/etc/group')|as|file: ||d|=|file.readline() ||while|'sudo'|not|in|d: ||||d=file.readline()  print('users',|users) d=d[:-1] splitted=d.split(':') usersInSudo=splitted[3].split(',') print(usersInSudo) for|user|in|usersInSudo: ||if|user|in|users: ||||os.system('gpasswd|-d|%s|sudo'%(user)) ||||pass"
echo '' > userReader.py
for i in $userReader; do i=$( tr '|' ' ' <<<"$i" ); echo "$i" >> userReader.py; done
python3 userReader.py

echo "Checking Root UID If not 0, please change to 0"
ROOTUID=$(id -u root)
if [ $ROOTUID -ne 0 ]; then
read -p "Fix Root UID to 0\nYou can do 'id -u root' to look at the UID of root\nthen go to /etc/passwd and change the UID\nSearch if you are unable to\nroot:x:0:0:root:/root:/bin/bash\nIt should look something like that"
else
echo "Root UID is set to 0"
fi

echo "Finding All media files, putting in media file: ~/Desktop/mediafiles.txt"
find / -name "*.midi" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.mid" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.mod" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.mp3" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.mp2" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.mpa" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.abs" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.mpega" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.au" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.snd" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.wav" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.aiff" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.aif" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.sid" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.flac" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.ogg" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.mpeg" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.mpg" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.mpe" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.dl" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.movie" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.movi" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.mv" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.iff" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.anim5" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.anim3" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.anim7" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.avi" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.vfw" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.avx" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.fli" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.flc" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.mov" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.qt" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.spl" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.swf" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.dcr" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.dir" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.dxr" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.rpm" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.rm" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.smi" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.ra" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.ram" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.rv" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.wmv" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.asf" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.asx" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.wma" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.wax" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.wmv" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.wmx" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.3gp" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.mov" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.mp4" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.avi" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.swf" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.flv" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.m4v" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.tiff" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.tif" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.rs" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.im1" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.gif" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.jpeg" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.jpg" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.jpe" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.png" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.rgb" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.xwd" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.xpm" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.ppm" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.pbm" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.pgm" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.pcx" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.ico" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.svg" -type f >> ~/Desktop/mediafiles.txt
find / -name "*.svgz" -type f >> ~/Desktop/mediafiles.txt
read -p "Waiting for media file clearance"

echo "Finding php files php files are service files"
find / -name "*.php" -type f >> ~/Desktop/phpfiles.txt
echo "All PHP files have been listed above. ('/var/cache/dictionaries-common/sqspell.php' is a system PHP file)"
read -p "php files in phpfiles.txt"

read -p "removing hacking tools, is that ok, do you still need them"
echo "Removing Netcat"
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

apt-get purge john -y -qq
apt-get purge john-data -y -qq
echo "John the Ripper has been removed."
apt-get purge hydra -y -qq
apt-get purge hydra-gtk -y -qq
echo "Hydra has been removed."
apt-get purge aircrack-ng -y -qq
echo "Aircrack-NG has been removed."
apt-get purge fcrackzip -y -qq
echo "FCrackZIP has been removed."
apt-get purge lcrack -y -qq
echo "LCrack has been removed."
apt-get purge ophcrack -y -qq
apt-get purge ophcrack-cli -y -qq
echo "OphCrack has been removed."
apt-get purge pdfcrack -y -qq
echo "PDFCrack has been removed."
apt-get purge pyrit -y -qq
echo "Pyrit has been removed."
apt-get purge rarcrack -y -qq
echo "RARCrack has been removed."
apt-get purge sipcrack -y -qq
echo "SipCrack has been removed."
apt-get purge irpas -y -qq
echo "IRPAS has been removed."
echo 'Are there any hacking tools shown? (not counting libcrack2:amd64 or cracklib-runtime)'
dpkg -l | egrep "crack|hack" >> ~/Desktop/Script.log
apt-get purge logkeys -y -qq
echo "LogKeys has been removed."

echo "Locking root account"
usermod -L root

unalias -a
echo "all alias have been removed. to add an alias, do: alias 'alias_name'='command' so like 'll'='ls -l'"

chmod 604 /etc/shadow
echo "Read/Write permissions on shadow have been set."

chmod 640 .bash_history
echo "Bash history file permissions set .bash_history"

find /bin/ -name "*.sh" -type f -delete
echo "Scripts in bin have been removed."

cp /etc/rc.local ~/Desktop/backups/
echo > /etc/rc.local
echo 'exit 0' >> /etc/rc.local
echo "Any startup scripts have been removed."

apt-get install ufw -y -qq
ufw enable
ufw deny 1337
echo "Firewall enabled and port 1337 blocked."

cp /etc/sudoers.d  ~/Desktop/backups/
read -p "Check for any files for users that should not be administrators in /etc/sudoers.d."

echo "Writing script to fix sysctl.conf"
scriptsysctlconfig="#open|/etc/sysctl.conf|and|read f=open('/etc/sysctlf.conf') text=f.read().split('\n') f.close() #Make|configs configs=['kernel.randomize_va_space','net.ipv4.icmp_echo_ignore_all','net.ipv4.ip_forward','net.ipv4.ip_forward','net.ipv4.conf.all.rp_filter','net.ipv4.conf.default.rp_filter','net.ipv4.icmp_echo_ignore_broadcasts','net.ipv4.conf.all.accept_source_route','net.ipv6.conf.all.accept_source_route','net.ipv4.conf.default.accept_source_route','net.ipv4.conf.all.send_redirects','net.ipv4.conf.default.send_redirects','net.ipv4.tcp_syncookies','net.ipv4.tcp_max_syn_backlog','net.ipv4.tcp_synack_retries','net.ipv4.tcp_syn_retries','net.ipv4.conf.all.log_martians','net.ipv4.icmp_ignore_bogus_error_responses','net.ipv4.conf.all.accept_redirects','net.ipv4.conf.default.accept_redirects','net.ipv4.conf.all.secure_redirects','net.ipv4.conf.default.secure_redirects','net.ipv6.conf.default.router_solicitations','net.ipv6.conf.default.accept_ra_rtr_pref','net.ipv6.conf.default.accept_ra_pinfo','net.ipv6.conf.default.accept_ra_defrtr','net.ipv6.conf.default.autoconf','net.ipv6.conf.default.dad_transmits'] fixes=['2','1',|'0','0','1','1','1','0','0','0','0','0','1','2048','2','5','1','1','0','0','0','0','0','0','0','0','0','0'] fixedtxt='' for|i|in|text: ||for|j|in|range(len(configs)): ||||if|configs[j]|in|i: ||||||x=i.split('=') ||||||x[1]=fixes[j] ||||||i=x[0]+'='+fixes[j] ||||||break ||fixedtxt+=i+'\n' #Write|configs|in|/etc/sysctl.conf f=open('/etc/sysctl.conf') f.write(fixedtxt) f.close()"
#Replaces | with a ' ' and every space in the string is a newline in the file
echo '' > sysctlconf.py
for i in $scriptsysctlconfig; do i=$( tr '|' ' ' <<<"$i" ); echo "$i" >> sysctlconf.py; done
cp /etc/sysctl.conf ~/Desktop/backups/
python3 sysctlconf.py
echo "Finished configuring /etc/sysctl.conf"

cp /etc/default/irqbalance ~/Desktop/backups/
echo > /etc/default/irqbalance
echo -e "#Configuration for the irqbalance daemon\n\n#Should irqbalance be enabled?\nENABLED=\"0\"\n#Balance the IRQs only once?\nONESHOT=\"0\"" >> /etc/default/irqbalance
echo "IRQ Balance has been disabled."

echo "For each of the below questions, just put Y or N, DO NOT UNCAP IT iS Y or N"
echo Does this machine need Samba?
read sambaYN
echo Does this machine need FTP?
read ftpYN
echo Does this machine need SSH?
read sshYN
echo Does this machine need Telnet?
read telnetYN
echo Does this machine need Mail?
read mailYN
echo Does this machine need Printing?
read printYN
echo Does this machine need MySQL?
read mysqlYN
echo Will this machine be a Web Server meaning apache2 is included in the PC?
read httpYN
echo Does this machine need DNS?
read dnsYN

chmod 777 /etc/hosts
cp /etc/hosts ~/Desktop/backups/
echo > /etc/hosts
echo -e "127.0.0.1 localhost\n127.0.1.1 $USER\n::1 ip6-localhost ip6-loopback\nfe00::0 ip6-localnet\nff00::0 ip6-mcastprefix\nff02::1 ip6-allnodes\nff02::2 ip6-allrouters" >> /etc/hosts
chmod 644 /etc/hosts
echo "HOSTS file has been set to defaults."

if [ $sambaYN == Y ]
then
echo "Fixing Samba"
echo "STILL NEED TO DO THIS"
elif [ $sambaYN == N ]
echo "Killing Samba"
ufw deny netbios-ns
ufw deny netbios-dgm
ufw deny netbios-ssn
ufw deny microsoft-ds
apt-get purge samba -y -qq
apt-get purge samba-common -y  -qq
apt-get purge samba-common-bin -y -qq
apt-get purge samba4 -y -qq
clear
echo "netbios-ns, netbios-dgm, netbios-ssn, and microsoft-ds ports have been denied. Samba has been removed."
then
else
echo "RESPONSE NOT RECOGNIZED FOR SAMBA"
fi
if [ $ftpYN == Y ]
then
echo "STILL NEED TO DO THIS"
elif [ $ftpYN == N ]
then
echo "Killing ftp"
ufw deny ftp 
ufw deny sftp 
ufw deny saft 
ufw deny ftps-data 
ufw deny ftps
apt-get purge vsftpd -y -qq
apt-get purge pureftpd -y -qq
apt-get purge pureftp -y -qq
apt-get purge pure-ftpd -y -qq
apt-get purge pure-ftp -y -qq
echo "vsFTPd has been removed. ftp, sftp, saft, ftps-data, pure-ftpd, and ftps ports have been denied on the firewall."
else
echo "RESPONSE NOT RECOGNIZED FOR ftp"
fi
if [ $sshYN == Y ]
then
echo "Fixing ssh"
apt-get install openssh-server -y -qq
ufw allow ssh
#sshconfig file is backed up by the python program. Dont worry
sshconfig="#Open|and|read|the|config|file|for|ssh File='/etc/ssh/sshd_config' try: ||f|=|open('/etc/ssh/sshd_config') except: ||File|=|input('What|is|the|ssh|configuration|file?|File|path|included:|') ||f|=|open(File) d=f.read() #Backing|up|the|config|file w=open('~/Desktop/backups/sshconfig.txt','w') w.write(d) w.close() d=d.split('\n') #Start|Fixing configs=['AllowTcpForwarding','Protocol','X11Forwarding','PasswordAuthentication','PermitRootLogin','RSAAuthentication','PubkeyAuthentication'] fixes=['no','2','no','no','no','yes','yes'] fixedtxt='' for|i|in|text: ||for|j|in|range(len(configs)): ||||if|configs[j]|in|i: ||||||x=i.split('|') ||||||x[1]=fixes[j] ||||||i=x[0]+'|'+fixes[j] ||||||break ||fixedtxt+=i+'\n' #Write|configs f=open(File) f.write(fixedtxt) f.close()"
echo '' > sshconfig.py
for i in $sshconfig; do i=$( tr '|' ' ' <<<"$i" ); echo "$i" >> sshconfig.py; done
python3 sshconfig.py
service ssh restart
mkdir ~/.ssh
chmod 700 ~/.ssh
ssh-keygen -t rsa
echo "Fixed ssh"
elif [ $sshYN == N ]
then
echo "Killing ssh"
ufw deny ssh
apt-get purge openssh-server -y -qq
echo "SSH port has been denied on the firewall. Open-SSH has been removed."
else
echo "RESPONSE NOT RECOGNIZED FOR ssh"
fi
if [ $telnetYN == Y ]
then
echo "STILL NEED TO DO THIS"
elif [ $telnetYN == N ]
then
echo "Killing Telnet"
ufw deny telnet 
ufw deny rtelnet 
ufw deny telnets
apt-get purge telnet -y -qq
apt-get purge telnetd -y -qq
apt-get purge inetutils-telnetd -y -qq
apt-get purge telnetd-ssl -y -qq
echo "Telnet port has been denied on the firewall and Telnet has been removed."
else
echo "RESPONSE NOT RECOGNIZED FOR telnet"
fi
if [ $mailYN == Y ]
then
echo "STILL NEED TO DO THIS"
elif [ $mailYN == N ]
then
echo "Killing mail"
ufw deny smtp 
ufw deny pop2 
ufw deny pop3
ufw deny imap2 
ufw deny imaps 
ufw deny pop3s
echo "smtp, pop2, pop3, imap2, imaps, and pop3s ports have been denied on the firewall."
else
echo "RESPONSE NOT RECOGNIZED FOR mail"
fi
if [ $printYN == Y ]
then
echo "STILL NEED TO DO THIS"
elif [ $printYN == N ]
then
echo "Killing print"
ufw deny ipp 
ufw deny printer 
ufw deny cups
echo "ipp, printer, and cups ports have been denied on the firewall."
else
echo "RESPONSE NOT RECOGNIZED FOR print"
fi
if [ $mysqlYN == Y ]
then
echo "STILL NEED TO DO THIS"
elif [ $mysqlYN == N ]
then
echo "Killing mysql"
ufw deny ms-sql-s 
ufw deny ms-sql-m 
ufw deny mysql 
ufw deny mysql-proxy
apt-get purge mysql -y -qq
apt-get purge mysql-client-core-5.5 -y -qq
apt-get purge mysql-client-core-5.6 -y -qq
apt-get purge mysql-common-5.5 -y -qq
apt-get purge mysql-common-5.6 -y -qq
apt-get purge mysql-server -y -qq
apt-get purge mysql-server-5.5 -y -qq
apt-get purge mysql-server-5.6 -y -qq
apt-get purge mysql-client-5.5 -y -qq
apt-get purge mysql-client-5.6 -y -qq
apt-get purge mysql-server-core-5.6 -y -qq
echo "ms-sql-s, ms-sql-m, mysql, and mysql-proxy ports have been denied on the firewall. MySQL has been removed."
else
echo "RESPONSE NOT RECOGNIZED FOR sql"
fi
if [ $httpYN == Y ]
then
echo "Getting apach2 and updating"
apt-get purge apache2 -y -qq
apt-get install apache2 -y -qq
ufw allow http 
ufw allow https
elif [ $httpYN == N ]
then
echo "Killing http and https and apache2"
ufw deny http
ufw deny https
apt-get purge apache2 -y -qq
rm -r /var/www/*
echo "http and https ports have been denied on the firewall. Apache2 has been removed. Web server files have been removed."
else
echo "RESPONSE NOT RECOGNIZED FOR web server"
fi
if [ $dnsYN == Y ]
then
echo "STILL NEED TO DO THIS"
elif [ $dnsYN == N ]
then
echo "Killing dns"
ufw deny domain
apt-get purge bind9 -qq
echo "domain port has been denied on the firewall. DNS name binding has been removed."
else
echo "RESPONSE NOT RECOGNIZED FOR dns"
fi

echo "Making updates"
apt upgrade -qq
apt update -qq
apt upgrade -qq

echo "AutoRemoving"
apt autoremove -y -qq
apt autoclean -y -qq

echo "Check the settings of updates"
echo "Instead of clicking update, click settings"
update-manager

read -p "Waiting for update settings to be fixed"

apt upgrade
apt update

echo "Creating filetimereader.py and readthedata.py"
echo "JK create it yourself"
read -p "Create filetimereader.py and readthedata.py"

echo "The script is done"
