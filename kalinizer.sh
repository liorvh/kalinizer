#!/bin/bash

# Links
ln -s /opt/ /root/Desktop/opt
ln -s /usr/share /root/Desktop/share
ln -s /var/www /root/Desktop/www
ln -s /etc/hosts /root/Desktop/hosts

# APT
cd /etc/apt && rm -rf sources.list
wget https://raw.githubusercontent.com/liorvh/kalinizer/master/sources.list
apt-get update && apt-get upgrade -y && apt-get dist-upgrade -y

# MiscDeps
apt-get install -y autoconf cmake libpopt-dev libtalloc-dev libtevent-dev libbsd-dev comerr.dev mingw32 mingw-w64 python-elixir ldap-utils rwho rsh-client x11-apps finger libpcap-dev masscan discover backdoor-factory winbind
update-java-alternatives --jre -s java-1.7.0-openjdk-amd64

# Nmaps
cd /usr/share/nmap/scripts
wget https://raw.githubusercontent.com/hdm/scan-tools/master/nse/banner-plus.nse
wget http://www.computec.ch/projekte/vulscan/download/nmap_nse_vulscan-2.0.tar.gz
tar xzf nmap_nse_vulscan-2.0.tar.gz
echo 'alias nmapvul="nmap -sV -script=vulscan/vulscan.nse "' >> ~/.bashrc

# Foofus
mkdir /opt/foofus && cd /opt/foofus
wget http://www.foofus.net/jmk/tools/owa/OWALogonBrute.pl
wget http://www.foofus.net/jmk/tools/owa/OWA55EnumUsersURL.pl
wget http://www.foofus.net/jmk/tools/owa/OWALightFindUsers.pl
wget http://www.foofus.net/jmk/tools/owa/OWAFindUsers.pl
wget http://www.foofus.net/jmk/tools/owa/OWAFindUsersOld.pl

# MITMf
cd /opt && git clone https://github.com/liorvh/MITMf mitmf
cd mitmf && ./kali_setup.sh

# Wordlists
mkdir /opt/wlists && cd /opt/wlists
wget http://download.g0tmi1k.com/wordlists/large/crackstation-human-only.txt.gz && gzip -d crackstation-human-only.txt.gz
wget http://downloads.skullsecurity.org/passwords/rockyou.txt.bz2 && bzip2 -d rockyou.txt.bz2
svn checkout http://fuzzdb.googlecode.com/svn/trunk/ fuzzdb
git clone https://github.com/liorvh/SecLists.git seclists

# Misc
cd /opt
git clone https://github.com/liorvh/patator.git
git clone https://github.com/liorvh/sparta.git

# Peepingtom
git clone https://bitbucket.org/LaNMaSteR53/peepingtom.git && cd /opt/peepingtom
wget https://gist.githubusercontent.com/nopslider/5984316/raw/423b02c53d225fe8dfb4e2df9a20bc800cc78e2c/gnmap.pl
wget http://phantomjs.googlecode.com/files/phantomjs-1.9.2-linux-x86_64.tar.bz2
tar xf phantomjs-1.9.2-linux-x86_64.tar.bz2
cp /opt/peepingtom/phantomjs-1.9.2-linux-x86_64/bin/phantomjs .

# Portmapper
cd /opt/ && git clone https://github.com/kaklakariada/portmapper.git
cd portmapper && ./gradlew build

# Wce
mkdir /opt/wce && cd /opt/wce
wget http://www.ampliasecurity.com/research/wce_v1_41beta_universal.zip
unzip -d /opt/wce/ wce_v1_41beta_universal.zip

# Powersploit
cd /usr/share/powersploit/
wget https://raw.githubusercontent.com/obscuresec/random/master/StartListener.py
wget https://raw.githubusercontent.com/darkoperator/powershell_scripts/master/ps_encoder.py

# Bypassuac
cd /tmp/ && wget https://www.trustedsec.com/files/bypassuac.zip && unzip bypassuac.zip
cp bypassuac/bypassuac.rb /opt/metasploit/apps/pro/msf3/scripts/meterpreter/
mv bypassuac/uac/ /opt/metasploit/apps/pro/msf3/data/exploits/

# Veil
mkdir /opt/veil && cd /opt/veil
wget https://raw.githubusercontent.com/liorvh/kalinizer/master/install.sh
chmod +x install.sh && ./install.sh -c

# Frenzy
echo "0.0.0.0 phishingfrenzy.local" >> /etc/hosts
curl -sSL https://get.docker.io/ubuntu/ | sudo sh
docker pull b00stfr3ak/ubuntu-phishingfrenzy
echo "service apache2 stop" >> /root/Desktop/runFrenzy.sh
echo "sleep 2" >> /root/Desktop/runFrenzy.sh
echo "docker run -d -p 80:80 b00stfr3ak/ubuntu-phishingfrenzy" >> /root/Desktop/runFrenzy.sh
echo "sleep 3" >> /root/Desktop/runFrenzy.sh
echo "firefox phishingfrenzy.local" >> /root/Desktop/runFrenzy.sh
chmod +x /root/Desktop/runFrenzy.sh

# Smbexec
cd /tmp/ && git clone https://github.com/liorvh/smbexec.git && cd /tmp/smbexec/
echo "[+] Select option 1"
/tmp/smbexec/install.sh
echo "[*] Where did you install SMBexec?: "
read smbexecpath && $smbexecpath/smbexec/install.sh
cd $smbexecpath/smbexec/ && bundle install

# Services
service postgresql start && service metasploit start && service apache2 start
update-rc.d postgresql enable && update-rc.d metasploit enable && update-rc.d apache2 enable

# Autologin
cd /etc/gdm3/ && rm -rf daemon.conf
wget https://raw.githubusercontent.com/liorvh/kalinizer/master/daemon.conf

# Wallpaper
cd /root/
wget http://fc08.deviantart.net/fs70/f/2013/264/5/7/kali_by_typograflaw-d6n6m8l.png
gsettings set org.gnome.desktop.background picture-uri "file:///root/kali_by_typograflaw-d6n6m8l.png"

echo
echo "[+] ~~~ Boom! ~~~"
echo

apt-get clean
rm -rf /tmp/*
rm -rf $0
