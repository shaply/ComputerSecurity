#!/bin/bash

echo "Make Sure You have Everything Set. All codes set. Root Set. Everything!"
echo "Linux Ubuntu Script\nThe Ultimate One\nLet's Pray it Works"

read -p "Make Sure you have done the forensics Questions"
read -p "Did you run as root? If not, rerun"
read -p "Did you make this in ~/Desktop/"
read -p "Make sure to run filetimereader.py on the side"

mkdir -p backups
chmod 777 backups

#save all of the logs before you begin messing with stuff
mkdir logs
echo "auth log:" > logs/authLogs.secu
cat /var/log/auth.log >> logs/authLogs.secu
#echo "" > logs/authLogs.secu
echo "dpkg log:" > logs/dpkgLogs.secu
cat /var/log/dpkg.log >> logs/dpkgLogs.secu
echo "" > logs/secureLogs.secu
cat /var/log/secure > logs/secureLogs.secu
echo  " " > logs/messageLogs.secu
cat /var/log/messages >> logs/messageLogs.secu
echo  " " > logs/historyLogs.secu
cat /var/log/apt/history.log >> logs/historyLogs.secu
echo " " > logs/historyLogs.secu
cp /root/.bash_history logs/root.bash_history

apt install libpam-cracklib -y

echo "Editting login.defs, TYPE IT IN YOURSELF"
cp /etc/login.defs backups/login.defs
read -p 'PASS_MAX_DAYS 90'
read -p 'PASS_MIN_DAYS 7'
read -p 'PASS_WARN_AGE 14'
read -p 'ENCRYPT_METHOD SHA512'
read -p 'UMASK 077'
read -p 'UID_MIN 1000'
read -p 'UID_MAX 60000'
read -p 'FAILLOG_ENAB yes'
read -p 'LOG_UNKFAIL_ENAB yes'
read -p 'SYSLOG_SU_ENAB yes'
read -p 'SYSLOG_SG_ENAB yes'
echo "Password policies have been set with /etc/login.defs."

echo "Downloading Python3, Vim, Updates, and stuff"
apt-get upgrade
apt-get update
apt-get install vim
apt install python3
apt-get install python3
read -p "Make sure python3, sed, and vim work, if not manually download"

scraper="import|urllib.request with|open('README.desktop')|as|file: ||d=file.read() d=d.split('\n') for|row|in|d: ||if|'https'|in|row: ||||s=row.split('https') ||||webUrl='https'+s[1][:-1] webUrl=urllib.request.urlopen(webUrl) data=webUrl.read().decode('UTF-8') data=data.split('\n') Gstuff=[] a=False for|row|in|data: ||if|a|and|'pre>'|not|in|row: ||||Gstuff.append(row) ||if|'pre>'|in|row: ||||if|a: ||||||break ||||else: ||||||a=True f=open('PCusers.secu',|'w') for|row|in|Gstuff: ||f.write(row) f.close()"
echo '' > scrapeREADME.py
for i in $scraper; do i=$( tr '|' ' ' <<<"$i" ); echo "$i" >> scrapeREADME.py; done
python3 scrapeREADME.py
read -p "Make sure the PCusers.secu file is correct/good"
read -p "I REPEAT MAKE SURE PCusers.secu file is good"

cp /etc/group backups/group.secu
userReader="with|open('PCusers.secu')|as|file: ||allLines=file.read().split('\n') ||admins=[] ||users=[] ||which='administrators'  ||for|row|in|allLines: ||||if|'password'|not|in|row.lower(): ||||||||if|'users'|in|row.lower(): ||||||||||which='users' ||||||||if|which|==|'administrators': ||||||||||if|'|'|in|row: ||||||||||||row=row.split()[0] ||||||||||admins.append(row) ||||||||if|which=='users': ||||||||||users.append(row) ||allusers=admins+users  ||#Doesn't|delete|users|from|sudo|group|yet ||import|os ||os.chdir('/home') ||allUser=os.listdir() ||for|user|in|allUser: ||||if|user|not|in|allusers: ||||||os.system('userdel|%s'%(user))  with|open('/etc/group')|as|file: ||d|=|file.readline() ||while|'sudo'|not|in|d: ||||d=file.readline()  print('users',|users) d=d[:-1] splitted=d.split(':') usersInSudo=splitted[3].split(',') print(usersInSudo) for|user|in|usersInSudo: ||if|user|in|users: ||||os.system('gpasswd|-d|%s|sudo'%(user)) ||||pass"
echo '' > userReader.py
for i in $userReader; do i=$( tr '|' ' ' <<<"$i" ); echo "$i" >> userReader.py; done
python3 userReader.py

echo "*** Do you need to add a user, if so type the users account name, other wise type N ***"
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
  echo "Do you need to add a user, if so type the users account name, other wise type N"
  read userYN
done

echo "Changing the Passwords for every user to T3@m_C7Ickb@it"
USERS=$( getent passwd {1000..6000} | cut -d: -f1 )
apt install whois
EncryptedPassword=$( mkpasswd -m sha-512 T3@m_C7Ickb@it )
for USER in $USERS; do
  usermod -p $EncryptedPassword $USER
  passwd -x30 -n3 -w7 $USER
  echo "$USER's password has been given a maximum age of 30 days, minimum of 3 days, and warning of 7 days." ;
done

echo "Checking Root UID If not 0, please change to 0"
ROOTUID=$(id -u root)
if [ $ROOTUID -ne 0 ]; then
  read -p "Fix Root UID to 0\nYou can do 'id -u root' to look at the UID of root\nthen go to /etc/passwd and change the UID\nSearch if you are unable to\nroot:x:0:0:root:/root:/bin/bash\nIt should look something like that"
else
  echo "Root UID is set to 0"
fi

chmod 644 "/etc/passwd"
echo "Look at /etc/passwd"
echo "Username:x:UID:GID:Comments:Home Directory:Command Shell"
read -p "Make sure all user UID are between 1000 and 60000"
read -p "Make sure all home directories are correct"
read -p "Make sure all command shells are right: /bin/bash, /sbin/nologin"

echo "Finding All media files, putting in media file: mediafiles.secu"
echo "What is the the home directory? ie /home"
read homeDir
find $homeDir -name "*.midi" -type f >> mediafiles.secu
find $homeDir -name "*.mid" -type f >> mediafiles.secu
find $homeDir -name "*.mod" -type f >> mediafiles.secu
find $homeDir -name "*.mp3" -type f >> mediafiles.secu
find $homeDir -name "*.mp2" -type f >> mediafiles.secu
find $homeDir -name "*.mpa" -type f >> mediafiles.secu
find $homeDir -name "*.abs" -type f >> mediafiles.secu
find $homeDir -name "*.mpega" -type f >> mediafiles.secu
find $homeDir -name "*.au" -type f >> mediafiles.secu
find $homeDir -name "*.snd" -type f >> mediafiles.secu
find $homeDir -name "*.wav" -type f >> mediafiles.secu
find $homeDir -name "*.aiff" -type f >> mediafiles.secu
find $homeDir -name "*.aif" -type f >> mediafiles.secu
find $homeDir -name "*.sid" -type f >> mediafiles.secu
find $homeDir -name "*.flac" -type f >> mediafiles.secu
find $homeDir -name "*.ogg" -type f >> mediafiles.secu
find $homeDir -name "*.mpeg" -type f >> mediafiles.secu
find $homeDir -name "*.mpg" -type f >> mediafiles.secu
find $homeDir -name "*.mpe" -type f >> mediafiles.secu
find $homeDir -name "*.dl" -type f >> mediafiles.secu
find $homeDir -name "*.movie" -type f >> mediafiles.secu
find $homeDir -name "*.movi" -type f >> mediafiles.secu
find $homeDir -name "*.mv" -type f >> mediafiles.secu
find $homeDir -name "*.iff" -type f >> mediafiles.secu
find $homeDir -name "*.anim5" -type f >> mediafiles.secu
find $homeDir -name "*.anim3" -type f >> mediafiles.secu
find $homeDir -name "*.anim7" -type f >> mediafiles.secu
find $homeDir -name "*.avi" -type f >> mediafiles.secu
find $homeDir -name "*.vfw" -type f >> mediafiles.secu
find $homeDir -name "*.avx" -type f >> mediafiles.secu
find $homeDir -name "*.fli" -type f >> mediafiles.secu
find $homeDir -name "*.flc" -type f >> mediafiles.secu
find $homeDir -name "*.mov" -type f >> mediafiles.secu
find $homeDir -name "*.qt" -type f >> mediafiles.secu
find $homeDir -name "*.spl" -type f >> mediafiles.secu
find $homeDir -name "*.swf" -type f >> mediafiles.secu
find $homeDir -name "*.dcr" -type f >> mediafiles.secu
find $homeDir -name "*.dir" -type f >> mediafiles.secu
find $homeDir -name "*.dxr" -type f >> mediafiles.secu
find $homeDir -name "*.rpm" -type f >> mediafiles.secu
find $homeDir -name "*.rm" -type f >> mediafiles.secu
find $homeDir -name "*.smi" -type f >> mediafiles.secu
find $homeDir -name "*.ra" -type f >> mediafiles.secu
find $homeDir -name "*.ram" -type f >> mediafiles.secu
find $homeDir -name "*.rv" -type f >> mediafiles.secu
find $homeDir -name "*.wmv" -type f >> mediafiles.secu
find $homeDir -name "*.asf" -type f >> mediafiles.secu
find $homeDir -name "*.asx" -type f >> mediafiles.secu
find $homeDir -name "*.wma" -type f >> mediafiles.secu
find $homeDir -name "*.wax" -type f >> mediafiles.secu
find $homeDir -name "*.wmv" -type f >> mediafiles.secu
find $homeDir -name "*.wmx" -type f >> mediafiles.secu
find $homeDir -name "*.3gp" -type f >> mediafiles.secu
find $homeDir -name "*.mov" -type f >> mediafiles.secu
find $homeDir -name "*.mp4" -type f >> mediafiles.secu
find $homeDir -name "*.avi" -type f >> mediafiles.secu
find $homeDir -name "*.swf" -type f >> mediafiles.secu
find $homeDir -name "*.flv" -type f >> mediafiles.secu
find $homeDir -name "*.m4v" -type f >> mediafiles.secu
find $homeDir -name "*.tiff" -type f >> mediafiles.secu
find $homeDir -name "*.tif" -type f >> mediafiles.secu
find $homeDir -name "*.rs" -type f >> mediafiles.secu
find $homeDir -name "*.im1" -type f >> mediafiles.secu
find $homeDir -name "*.gif" -type f >> mediafiles.secu
find $homeDir -name "*.jpeg" -type f >> mediafiles.secu
find $homeDir -name "*.jpg" -type f >> mediafiles.secu
find $homeDir -name "*.jpe" -type f >> mediafiles.secu
find $homeDir -name "*.png" -type f >> mediafiles.secu
find $homeDir -name "*.rgb" -type f >> mediafiles.secu
find $homeDir -name "*.xwd" -type f >> mediafiles.secu
find $homeDir -name "*.xpm" -type f >> mediafiles.secu
find $homeDir -name "*.ppm" -type f >> mediafiles.secu
find $homeDir -name "*.pbm" -type f >> mediafiles.secu
find $homeDir -name "*.pgm" -type f >> mediafiles.secu
find $homeDir -name "*.pcx" -type f >> mediafiles.secu
find $homeDir -name "*.ico" -type f >> mediafiles.secu
find $homeDir -name "*.svg" -type f >> mediafiles.secu
find $homeDir -name "*.svgz" -type f >> mediafiles.secu
read -p "Waiting for media file clearance"

echo "" > allFiles.secu
ls -aR $homeDir >> allFiles.secu
read -p "Look at allFiles.secu and check for any files that are not .secu extension"

echo "Finding php files php files are service files"
echo "" > phpfiles.secu
find / -name "*.php" -type f >> phpfiles.secu
echo "All PHP files have been listed above. ('/var/cache/dictionaries-common/sqspell.php' is a system PHP file)"
read -p "php files in phpfiles.secu"

echo $( alias ) > alias.secu
read -p "Check alias.secu, if there are any bad alias, then unalias it"

chmod 604 /etc/shadow
echo "Read/Write permissions on shadow have been set."

chmod 640 .bash_history
echo "Bash history file permissions set .bash_history"

echo "" > scriptsInBin.secu
echo $( find /bin/ -name "*.sh" -type f ) >> scriptsInBin.secu
read -p "Look at scriptsInBin.secu"
find /bin/ -name "*.sh" -type f -delete
echo "Scripts in bin have been removed."

echo "" > scriptsInUsers.secu
echo $( find ~/.. -name "*.sh" -type f ) >> scriptsInUsers.secu
read -p "Look at scriptsInUsers.secu"
read -p "Check if some should be removed"

cp /etc/rc.local backups/rc.local
echo > /etc/rc.local
echo 'exit 0' >> /etc/rc.local
echo "Any startup scripts have been removed."

cp /etc/lightdm/lightdm.conf backups/lightdm.conf
echo "allow-guest=false" >> /etc/lightdm/lightdm.conf
echo "Turned guest off for lightdm"
read -p "Check to make sure allow-guest=false is in /etc/lightdm/lightdm.conf"

#Clears out the control-alt-delete, as this could possibly be a problem
echo "# control-alt-delete - emergency keypress handling
#
# This task is run whenever the Control-Alt-Delete key combination is
# pressed, and performs a safe reboot of the machine.
description	\'emergency keypress handling\'
author		\'Scott James Remnant <scott@netsplit.com>\'
start on control-alt-delete
task
exec false" > /etc/init/control-alt-delete.conf
echo "Finished cleaning control-alt-delete"

apt-get install ufw -y -qq
ufw enable
ufw reset
ufw enable
ufw allow http
ufw allow https
ufw deny 23
ufw deny 2049
ufw deny 515
ufw deny 111
ufw deny 1337
ufw logging high
echo "Firewall enabled and configged"

apt-get install gufw 
read -p "Turn the options 'incoming' to reject, 'outgoing' to allow, 'status' to on, 'profile' to home"
gufw
read -p "Turn the options 'incoming' to reject, 'outgoing' to allow, 'status' to on, 'profile' to home"

cp /etc/sudoers.d  backups/sudoers.d
echo "sudoers.d should have lines:
# User privilege specification
root	ALL=(ALL:ALL) ALL
# Members of the admin group may gain root privileges
%admin ALL=(ALL) ALL
# Allow members of group sudo to execute any command
%sudo	ALL=(ALL:ALL) ALL"
read -p "Check for any files for users that should not be administrators in /etc/sudoers.d."

#Determines if there are any netcat backdoors running, and will delete some of them
echo "" > backdoors.secu
netstat -ntlup | grep -e "netcat" -e "nc" -e "ncat" >> backdoors.secu
echo "Attempted to find any backdoors and put in backdoors.secu"

read -p "don't forget to run netstat to find backdoors or stuff by your self"

echo $( ls -Rl /home/ ) > userFiles.secu
read -p "Just in case, look for files in directories of users again in userFiles.secu"

#Remove any bad files that are in the users cron in /var/spool/cron/crontabs
read -p "Look at /var/spool/cron/crontabs to see if there are any good/needed files, because once script remove, will need to add back"
for i in $(ls /var/spool/cron/crontabs); do
	cp /var/spool/cron/crontabs/$i backups/$i;
	rm /var/spool/cron/crontabs/$i;
done
echo "finished removing files in /var/spool/cron/crontabs"

cp /etc/environment backups/environment.secu
echo 'PATH=\"/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin\"' > /etc/environment
echo "Finished cleaning the /etc/environment"

echo "Installing clamav the virus scanner"
apt-get install clamav
clamscan -r / > infected_badFiles.secu
read -p "Read for vulnerabilities"

echo "Installing rkhunter to find bad things"
apt install rkhunter -y
rkhunter --c --enable all --disable none > rkhunterScan.secu
echo "Installing Chkroot to find rootkits"
apt install chkrootkit -y
chkrootkit > chkrootkitScan.secu
read -p "Look at rkhunterScan.secu and chkrootkitScan.secu"

read -p "Do you still need hacking tools? After enter, hacking tools will be removed"
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
apt-get purge hydra -y
apt-get purge hydra-gtk -y
echo "Hydra has been removed."
apt-get purge aircrack-ng -y
echo "Aircrack-NG has been removed."
apt-get purge fcrackzip -y 
echo "FCrackZIP has been removed."
apt-get purge lcrack -y 
echo "LCrack has been removed."
apt-get purge ophcrack -y
apt-get purge ophcrack-cli -y 
echo "OphCrack has been removed."
apt-get purge pdfcrack -y 
echo "PDFCrack has been removed."
apt-get purge pyrit -y 
echo "Pyrit has been removed."
apt-get purge rarcrack -y 
echo "RARCrack has been removed."
apt-get purge sipcrack -y 
echo "SipCrack has been removed."
apt-get purge irpas -y 
echo "IRPAS has been removed."
apt-get purge zenmap nmap -y
echo "Zenmap and nmap has been removed."
echo 'Are there any hacking tools shown? (not counting libcrack2:amd64 or cracklib-runtime)'
dpkg -l | egrep "crack|hack" >> Script.log
apt-get purge logkeys -y
echo "LogKeys has been removed."
apt purge medusa -y
dpkg --remove netcat
apt purge crack -y
dpkg --remove crack
echo "crack has been removed"
read -p "Look at Script.log and see if any hack apps in there"

echo "Check the settings of updates"
echo "Instead of clicking update, click settings"
update-manager

read -p "Waiting for update settings to be fixed"

echo "deb http://security.ubuntu.com/ubuntu/ trusty-security main universe
deb http://us.archive.ubuntu.com/ubuntu/ trusty-updates main universe" >> /etc/apt/sources.list
add-apt-repository "deb http://archive.canonical.com/ubuntu precise partner"
add-apt-repository "deb http://archive.ubuntu.com/ubuntu precise multiverse main universe restricted"
add-apt-repository "deb http://security.ubuntu.com/ubuntu/ precise-security universe main multiverse restricted"
add-apt-repository "deb http://archive.ubuntu.com/ubuntu precise-updates universe main multiverse restricted"
echo "Updates also come from security and recommended updates"
echo "Make SURE you still check out /etc/apt/sources.list to see if there are any bad links"

echo $( comm -23 <(apt-mark showmanual | sort -u) <(gzip -dc /var/log/installer/initial-status.gz | sed -n 's/^Package: //p' | sort -u) ) > "manuallyInstalled.secu"
read -p "look at manuallyInstalled.secu for manually installed apps"

apt update
apt upgrade
apt update

echo "AutoRemoving"
apt autoremove -y -qq
apt autoclean -y -qq

#makes updates happen daily
echo 'APT::Periodic::Update-Package-Lists \"1\";
APT::Periodic::Download-Upgradeable-Packages \"0\";
APT::Periodic::AutocleanInterval \"0\";' > /etc/apt/apt.conf.d/10periodic
echo "Checks for updates automatically"

echo "Writing script to fix sysctl.conf"
scriptsysctlconfig=' import|os #open|/etc/sysctl.conf|and|read File="/etc/sysctl.conf" try: ||f=open(File) ||text=f.read() ||f.close() except: ||File=input("what|is|the|file|path|for|sysctl?|") ||f=open(File) ||text=f.read() ||f.close() #Make|configs configs=["kernel.randomize_va_space","net.ipv4.ip_forward","net.ipv4.conf.all.rp_filter","net.ipv4.tcp_syncookies","net.ipv4.icmp_echo_ignore_broadcasts","net.ipv4.conf.all.log_martians","net.ipv4.tcp_rfc1337","net.ipv6.conf.all.rp_filter","net.ipv4.tcp_timestamps","net.ipv4.icmp_ignore_bogus_error_responses","net.ipv4.conf.all.send_redirects","net.ipv4.conf.default.accept_redirects","net.ipv4.conf.all.accept_redirects","net.ipv6.conf.default.accept_redirects","net.ipv6.conf.all.accept_redirects"] fixes=["1","0","1","1","1","1","1","1","0","1","0","0","0","0","0"] fixedtxt=text for|i|in|range(len(configs)): ||fixedtxt+="\\n"+configs[i]+"="+fixes[i] ||os.system("sysctl|"+configs[i]+"="+fixes[i]) #Making|configs|with|search|in|terminal #Write|configs|in|/etc/sysctl.conf f=open(File,"w") f.write(fixedtxt) f.close()'
#Replaces | with a ' ' and every space in the string is a newline in the file
echo '' > sysctlconf.py
for i in $scriptsysctlconfig; do i=$( tr '|' ' ' <<<"$i" ); echo "$i" >> sysctlconf.py; done
cp /etc/sysctl.conf backups/sysctl.conf
python3 sysctlconf.py
echo "Finished configuring /etc/sysctl.conf. If there is the \n error in the file, then just do ctrl+h in gedit, and then type in the find box:'\\\n' and replace with \n"

install cracklib
install auditd
passwd -l root

echo "If the :0:0: appears for anyone else, then make sure you config it because that only appears for root"
echo "Check the home directories of the users and root to make sure they are the right ones, you can find it in the section similar to :/root:"
echo "Check the last section, this is the thing that is run when someone logs (it is their terminal) in as that user, make sure it is safe"
echo "For users, that last section should just be /bin/bash"
read -p "Go in the passwd file and check if there are any uses root:x:0:0:root:/root:/bin/bash except the root and stuff are different"
read -p "Go in /etc/shadow file to check for any bad passwords"

#This clears out the HOST file so that unintentional/malicious networks are accidentally accessed.
echo "Clearing HOSTS file"
cp /etc/hosts backups/hosts.secu
echo "127.0.0.1	localhost" > /etc/hosts
echo "127.0.1.1	ubuntu"  >> /etc/hosts
echo "::1     ip6-localhost ip6-loopback" >> /etc/hosts
echo "fe00::0 ip6-localnet" >> /etc/hosts
echo "ff00::0 ip6-mcastprefix" >> /etc/hosts
echo "ff02::1 ip6-allnodes" >> /etc/hosts
echo "ff02::2 ip6-allrouters" >> /etc/hosts

chown root:root /etc/securetty
chmod 0600 /etc/securetty
chmod 644 /etc/crontab
chmod 640 /etc/ftpusers
chmod 440 /etc/inetd.conf
chmod 440 /etc/xinetd.conf
chmod 400 /etc/inetd.d
chmod 644 /etc/hosts.allow
chmod 440 /etc/sudoers
chmod 640 /etc/shadow
chown root:root /etc/shadow
echo "Finished changing some common file permissions"

#restart all of the DNS caches to clear out any unwanted connections
/etc/init.d/dnsmasq restart > cacheClearing.secu
/etc/init.d/nscd -i hosts >> cacheClearing.secu #some others said reload or restart would do the same thing
/etc/init.d/nscd reload >> cacheClearing.secu
rndc flush >> cacheClearing.secu	#this clears the cache when bind9 is installed
echo "Clearing computer cache:" >> cacheClearing.secu
#These next few clear out the cache on the computer
free >> cacheClearing.secu
sync && echo 3 > /proc/sys/vm/drop_caches
#echoing the 3 in drop_caches tells the system to ___________________
echo "After" >> cacheClearing.secu
free >> cacheClearing.secu
echo "Finished restarting caches"
service xinetd reload

#Make cron.allow and at.allow and deleting cron.deny and at.deny
/bin/rm -f /etc/cron.deny
/bin/rm -f /etc/at.deny
echo "root" > /etc/cron.allow
echo "root" > /etc/at.allow
/bin/chown root:root /etc/cron.allow
/bin/chown root:root /etc/at.allow
/bin/chmod 400 /etc/at.allow
/bin/chmod 400 /etc/cron.allow
echo "Finished creating cron/at.allow and deleting cron/at.deny"

chmod 644 /etc/profile.d
chown root:root /etc/profile.d

#Uses find, looks for type of regular file that has either permissions of suid of 2000 or 4000
echo "" > suspectFind.secu
echo "Suspicious SUID permission files" > suspectFind.secu
find / -type f \( -perm -04000 -o -perm -02000 \) >> suspectFind.secu 
read -p "Finished looking for suspicious files with SUID permissions, in suspectFind.secu"


#Finds files that appear to be placed down by no one. Would tell you if someone placed down something, then removed their user leaving that file around
echo "Finding files with no Family" >> suspectFind.secu
find / \( -nouser -o -nogroup \) >> suspectFind.secu
echo "" >> suspectFind.secu
read -p "Finished looking for suspicious file with no user/group, in suspectFind.secu"

#finds directories that can be written by anyone, anywhere
echo "" > worldWrite.secu
echo "finding world writable files" >> worldWrite.secu
find / -perm -2 ! -type l -ls >> worldWrite.secu
read -p "Finished looking for world writable files, worldWrite.secu"

echo "" > services.secu
service --status-all | grep "+" >> services.secu
read -p "All active services in services.secu"

dpkg -l > apps.secu
gedit apps.secu &
read -p "Fix apps.secu as need be so that only the lines with app names are in the file"
echo "" > writeApps.py
writeApps='fixed|=|"" with|open("apps.secu")|as|file: ||d|=|file.readline() ||x|=|"N" ||while|(x|==|"N"): ||||a|=|input("Which|column|is|the|app|name|in|on|each|line?,|like|1,2,3...") ||||a|=|int(a) ||||print(d.split()[a-1]) ||||x|=|input("Is|this|the|right|column?,|YN") ||while|(d): ||||fixed|+=|d.split()[a-1]|+|"\n" ||||d|=|file.readline() with|open("ALLAPPS.secu","w")|as|file: ||file.write(fixed)'
for i in $writeApps; do i=$( tr '|' ' ' <<<"$i" ); echo "$i" >> writeApps.py; done
python3 writeApps.py
echo "Check to make sure ALLAPPS.secu is correct"
read -p "Download the BaseApps[version].secu from github, AND PUT THE FILE IN DESKTOP AS correctapps.secu"
appChecker='dFiles|=|open("ALLAPPS.secu") cFiles|=|open("correctapps.secu") d|=|dFiles.read().split() c|=|cFiles.read().split() dFiles.close() cFiles.close() some|=|open("appsCompared.secu","w") some.write("APPS|IN|IMAGE|NOT|IN|BASE|\n") for|i|in|d: ||if|(i|not|in|c): ||||some.write(i) ||||some.write("\n") some.write("\n") some.write("APPS|NOT|IN|IMAGE|IN|BASE|\n") for|i|in|c: ||if|(i|not|in|d): ||||some.write(i) ||||some.write("\n") some.close()'
echo "" > appChecker.py
for i in $appChecker; do i=$( tr '|' ' ' <<<"$i" ); echo "$i" >> appChecker.py; done
python3 appChecker.py
gedit appsCompared.secu &
read -p "Look at appsCompared.secu"




echo "For each of the below questions, just put Y or N, DO NOT UNCAP IT iS Y or N"
echo "BEFORE YOU DO THIS STUFF, MAKE SURE YOU CHECK OUT THE EXISTING SERVICES TO SEE IF YOU CAN FIND ANYTHING FROM THEM, ALSO YOU DON'T REALLY NEED TO DELETE THEM"
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
echo Will this machine need apache2?
read apacheYN
echo Does this machine need DNS?
read dnsYN

if [ $sambaYN == Y ]
then
  echo "Fixing Samba"
  echo "STILL NEED TO DO THIS"
elif [ $sambaYN == N ]
then
  read -p "Killing Samba; ufw deny microsoft-ds; apt-get purge samba -y -qq; apt-get purge samba-common -y  -qq; apt-get purge samba-common-bin -y -qq; apt-get purge samba4 -y -qq"
else
  echo "RESPONSE NOT RECOGNIZED FOR SAMBA"
fi
if [ $ftpYN == Y ]
then
  echo "STILL NEED TO DO THIS"
elif [ $ftpYN == N ]
then
  read -p "Killing ftp; ufw deny ftp; ufw deny sftp; ufw deny saft; ufw deny ftps-data; ufw deny ftps; apt-get purge vsftpd -y -qq; apt-get purge pureftpd -y -qq; apt-get purge pureftp -y -qq; apt-get purge pure-ftpd -y -qq; apt-get purge pure-ftp -y -qq"
else
  echo "RESPONSE NOT RECOGNIZED FOR ftp"
fi
if [ $sshYN == Y ]
then
  echo "Fixing ssh"
  apt-get install openssh-server -y -qq
  ufw allow ssh
  #sshconfig file is backed up by the python program. Dont worry
  sshconfig="#Open|and|read|the|config|file|for|ssh File='/etc/ssh/sshd_config' try: ||f|=|open(File) except: ||File|=|input('What|is|the|ssh|configuration|file?|File|path|included:|') ||f|=|open(File) d=f.read() f.close() #Backing|up|the|config|file w=open('backups/sshconfig.secu','w') w.write(d) w.close() text=d.split('\n') #Start|Fixing configs=['AllowTcpForwarding','Protocol','X11Forwarding','PasswordAuthentication','PermitRootLogin','RSAAuthentication','PubkeyAuthentication'] fixes=['no','2','no','no','no','yes','yes'] fixedtxt='' for|i|in|text: ||for|j|in|range(len(configs)): ||||if|configs[j]|in|i: ||||||x=i.split('|') ||||||tmp='' ||||||for|k|in|x: ||||||||if|k==configs[j]: ||||||||||tmp+=k ||||||||||break ||||||||tmp+=k+'|' ||||||i=tmp+'|'+fixes[j] ||||||break ||fixedtxt+=i+'\n' fixedtxt+='\n' print(configs,|fixes) for|i|in|range(len(configs)): ||if|configs[i]!='': ||||fixedtxt+=configs[i]+'|'+fixes[i]+'\n' #Write|configs f=open(File,'w') f.write(fixedtxt) f.close()"
  /usr/sbin/sshd -T
  read -p "Just printed a think that will tell if there is any bad lines in the config file, make sure to delete accordingly"
  read -p "Check /etc/ssh/ssh_config (If it exists) as well and change the settings according to what was changed in /etc/ssh/sshd_config by script"
  echo '' > sshconfig.py
  for i in $sshconfig; do i=$( tr '|' ' ' <<<"$i" ); echo "$i" >> sshconfig.py; done
  python3 sshconfig.py
  read -p "Check /etc/ssh/sshd_config to make sure the correct settings were added (Just check the script code)"
  service ssh restart
  mkdir ~/.ssh
  chmod 700 ~/.ssh
  echo "Fixed ssh"
elif [ $sshYN == N ]
then
  read -p "Killing ssh; ufw deny ssh; apt-get purge openssh-server -y -qq"
else
  echo "RESPONSE NOT RECOGNIZED FOR ssh"
fi
if [ $telnetYN == Y ]
then
  echo "STILL NEED TO DO THIS"
elif [ $telnetYN == N ]
then
  read -p "Killing Telnet; ufw deny telnet; ufw deny rtelnet; ufw deny telnets; apt-get purge telnet -y -qq; apt-get purge telnetd -y -qq; apt-get purge inetutils-telnetd -y -qq; apt-get purge telnetd-ssl -y -qq"
else
  echo "RESPONSE NOT RECOGNIZED FOR telnet"
fi
if [ $mailYN == Y ]
then
  echo "STILL NEED TO DO THIS"
elif [ $mailYN == N ]
then
  echo "Killing mail; ufw deny smtp; ufw deny pop2; ufw deny pop3; ufw deny imap2; ufw deny imaps; ufw deny pop3s"
else
echo "RESPONSE NOT RECOGNIZED FOR mail"
fi
if [ $printYN == Y ]
then
  echo "STILL NEED TO DO THIS"
elif [ $printYN == N ]
then
  read -p "Killing print; ufw deny ipp; ufw deny printer; ufw deny cups"
else
echo "RESPONSE NOT RECOGNIZED FOR print"
fi
if [ $mysqlYN == Y ]
then
  service mysql start
  echo "In the mysql terminal, run the following commands"
  echo "mysql > select host, user, password from user;"
  echo "Then Change as necessary, to change the password do: mysql > update user set password=password('T3@m_C7Ickb@it') where user='USERNAME'; "
  echo "Then do look at the grants for each user: mysql > show grants for 'USERNAME'; "
  echo "Then edit as necessary: mysql > revoke 'PERMISSION' on 'DATABASE(* for all)'.'TABLE(* for all)' from 'USERNAME'; to remove privileges"
  echo "To add privileges do: mysql > grant 'PERMISSION' on 'DATABASE(* for all)'.'TABLE(* for all)' to 'USERNAME'; "
  echo "Type in the password for the root account below"
  mysql -u root -p mysql
  read -p "If there was an error, try to find another way to get into mysql as root before continuing the script"
  echo "STILL NEED TO ADD"
elif [ $mysqlYN == N ]
then
  read -p "Killing mysql; ufw deny ms-sql-s; ufw deny ms-sql-m; ufw deny mysql; ufw deny mysql-proxy; apt-get purge mysql -y -qq; apt-get purge mysql-client-core-5.5 -y -qq;   apt-get purge mysql-client-core-5.6 -y -qq; apt-get purge mysql-common-5.5 -y -qq; apt-get purge mysql-common-5.6 -y -qq; apt-get purge mysql-server -y -qq; apt-get purge mysql-server-5.5 -y -qq; apt-get purge mysql-server-5.6 -y -qq; apt-get purge mysql-client-5.5 -y -qq; apt-get purge mysql-client-5.6 -y -qq; apt-get purge mysql-server-core-5.6 -y -qq"
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
  iptables –A INPUT –p tcp –dport 80 –m limit –limit 25/minute –limit-burst 100 –j ACCEPT
elif [ $httpYN == N ]
then
  read -p "Killing http and https and apache2; ufw deny http; ufw deny https; apt-get purge apache2 -y -qq; rm -r /var/www/*"
else
  echo "RESPONSE NOT RECOGNIZED FOR web server"
fi
if [ $dnsYN == Y ]
then
  echo "STILL NEED TO DO THIS"
elif [ $dnsYN == N ]
then
  read -p "Killing dns; ufw deny domain; apt-get purge bind9 -qq "
else
  echo "RESPONSE NOT RECOGNIZED FOR dns"
fi

echo "Need to add audit stuff too"

echo "AI Stuff"

apt install lynis
lynis audit system
read -p "Lynis ran"

find /etc ! -user root > notRootOwned.secu
find /etc -perm /o+w > badFilePermsinEtc.secu
read -p "Bad etc files in notRootOwned.secu and badFilePermsinEtc.secu"

curl -L https://github.com/carlospolop/PEASS-ng/releases/latest/download/linpeas.sh | sh

read -p "*** Edit firefox settings as well. Video of what to do **(Skip to 6:45)**: https://www.youtube.com/watch?v=JVxkTqLoyGY ***"
read -p "*** Make sure to do pam stuff, follow: https://s3.amazonaws.com/cpvii/Training+materials/Unit+Eight+-+Ubuntu+Security.pdf ***"
read -p "*** Run ETCFilePerm.py and make sure all file settings besides rc and some other files are set at most to -rwxr-xr-x and owned by root ***"
read -p "*** Find Trojans in /etc/rc* by looking at added time and comparing with others, and in /tmp ***"
read -p "*** Checklist for critical services include: Making sure they work, making sure they start up at boot, making sure configs are right, making sure file perms are right ***"
read -p "*** When using the time reader and stuff, check: /etc, /usr, /opt, /home ***VERY IMPORTANT"
read -p "*** ALL FILES ARE CREATED IN THE DESKTOP DIRECTOR, SO ANY FILE FOUND THaT IS NOT IN THE DESKTOP FOLDER IS PROBABLY NOT GOOD ***"
echo "Finally, do the time reader stuff and good luck!"
