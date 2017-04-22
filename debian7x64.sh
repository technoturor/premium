#!/bin/bash
myip=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0' | head -n1`;
myint=`ifconfig | grep -B1 "inet addr:$myip" | head -n1 | awk '{print $1}'`;

flag=0

echo


if [ $USER != 'root' ]; then
	echo "Sorry, for run the script please using root user"
	exit
fi
echo "
AUTOSCRIPT BY YUSUF ARDIANSYAH

PLEASE CANCEL ALL PACKAGE POPUP

TAKE NOTE !!!"
clear
echo "START AUTOSCRIPT"
clear
echo "SET TIMEZONE JAKARTA GMT +7"
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime;
clear
echo "
ENABLE IPV4 AND IPV6

COMPLETE 1%
"
echo ipv4 >> /etc/modules
echo ipv6 >> /etc/modules
sysctl -w net.ipv4.ip_forward=1
sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf
sed -i 's/#net.ipv6.conf.all.forwarding=1/net.ipv6.conf.all.forwarding=1/g' /etc/sysctl.conf
sysctl -p
clear
echo "
REMOVE SPAM PACKAGE

COMPLETE 10%
"
apt-get -y --purge remove samba*;
apt-get -y --purge remove apache2*;
apt-get -y --purge remove sendmail*;
apt-get -y --purge remove postfix*;
apt-get -y --purge remove bind*;
apt-get -y --purge remove dropbear*;


echo "
UPDATE AND UPGRADE PROCESS 

PLEASE WAIT TAKE TIME 1-5 MINUTE
"
# install essential package
apt-get -y install bmon iftop htop nmap axel nano traceroute sysv-rc-conf bash curl zip sudo
apt-get -y dnsutils bc nethogs less screen psmisc apt-file whois ptunnel ngrep mtr git zsh mrtg snmp snmpd snmp-mibs-downloader unzip rsyslog debsums rkhunter
apt-get -y install build-essential

apt-get update;apt-get -y upgrade;apt-get -y install wget curl
echo "
INSTALLER PROCESS PLEASE WAIT
TAKE TIME 5-10 MINUTE
"
# login setting
echo "/bin/false" >> /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells
# squid3
apt-get update
apt-get -y install squid3
wget -O /etc/squid3/squid.conf "https://raw.githubusercontent.com/deeniedoank/autoscript2/master/squid/squid.conf"
sed -i "s/ipserver/$myip/g" /etc/squid3/squid.conf
chmod 0640 /etc/squid3/squid.conf

# text warna
cd
rm -rf .bashrc
wget https://raw.githubusercontent.com/deeniedoank/autoscript2/master/text%20warna/.bashrc

# text pelangi
sudo apt-get install ruby -y
sudo gem install lolcat

# nginx
apt-get -y install nginx php5-fpm php5-cli
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
wget -O /etc/nginx/nginx.conf "https://raw.githubusercontent.com/deeniedoank/autoscript2/master/conf/nginx.conf"
mkdir -p /home/vps/public_html
echo "<pre>Setup by YusufArdiansyah | telegram : e-Server | Pin BBM : yu-suf</pre>" > /home/vps/public_html/index.php
echo "<?php phpinfo(); ?>" > /home/vps/public_html/info.php
wget -O /etc/nginx/conf.d/vps.conf "https://raw.githubusercontent.com/deeniedoank/autoscript2/master/conf/vps.conf"
sed -i 's/listen = \/var\/run\/php5-fpm.sock/listen = 127.0.0.1:9000/g' /etc/php5/fpm/pool.d/www.conf

# install openvpn
apt-get install openvpn -y
wget -O /etc/openvpn/openvpn.tar "https://raw.github.com/deeniedoank/autoscript2/master/conf/openvpn-debian.tar"
cd /etc/openvpn/
tar xf openvpn.tar
wget -O /etc/openvpn/1194.conf "https://raw.github.com/deeniedoank/autoscript2/master/conf/1194.conf"
service openvpn restart
sysctl -w net.ipv4.ip_forward=1
sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf
wget -O /etc/iptables.conf "https://raw.github.com/deeniedoank/autoscript2/master/conf/iptables.conf"
sed -i '$ i\iptables-restore < /etc/iptables.conf' /etc/rc.local

myip2="s/ipserver/$myip/g";
sed -i $myip2 /etc/iptables.conf;
iptables-restore < /etc/iptables.conf
service openvpn restart

# configure openvpn client config
cd /etc/openvpn/
wget -O /etc/openvpn/1194-client.ovpn "https://raw.github.com/deeniedoank/autoscript2/master/conf/1194-client.conf"
sed -i $myip2 /etc/openvpn/1194-client.ovpn;
PASS= `cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 15 | head -n 1`;
usermod -s /bin/false mail
echo "mail:deenie" | chpasswd
useradd -s /bin/false -M deenie11
echo "deenie11:deenie" | chpasswd
tar cf client.tar 1194-client.ovpn
cp client.tar /home/vps/public_html/

# setting port ssh
sed -i '/Port 22/a Port 80' /etc/ssh/sshd_config
sed -i 's/Port 22/Port  22/g' /etc/ssh/sshd_config
service ssh restart

# install dropbear

apt-get -y install dropbear
sed -i 's/NO_START=1/NO_START=0/g' /etc/default/dropbear
sed -i 's/DROPBEAR_PORT=22/DROPBEAR_PORT=109/g' /etc/default/dropbear
sed -i 's/DROPBEAR_EXTRA_ARGS=/DROPBEAR_EXTRA_ARGS="-p 443"/g' /etc/default/dropbear
echo "/bin/false" >> /etc/shells
service ssh restart
service dropbear restart

# bannerssh
wget https://raw.githubusercontent.com/deeniedoank/autoscript2/master/menu/bannersshlink.sh
chmod 700 bannersshlink.sh
./bannersshlink.sh
rm bannersshlink.sh

# install fail2ban
apt-get -y install fail2ban
service fail2ban restart

# install webmin
cd
wget http://prdownloads.sourceforge.net/webadmin/webmin_1.820_all.deb
dpkg --install webmin_1.820_all.deb
apt-get -y -f install
rm /root/webmin_1.820_all.deb
sed -i 's/ssl=1/ssl=0/g' /etc/webmin/miniserv.conf
service webmin restart

# auto reboot 24jam
cd
echo "0 0 * * * root /usr/bin/reboot" > /etc/cron.d/reboot
echo "0 0 * * * root service dropbear restart" > /etc/cron.d/dropbear

# auto kill dropbear
#wget "https://raw.githubusercontent.com/deeniedoank/autoscript2/master/menu/userlimit.sh"
#mv ./userlimit /usr/bin/userlimit.sh
#chmod +x /usr/bin/userlimit.sh
#echo " /etc/security/limits.conf" > /etc/security/limits.conf

# auto kill openssh
#wget "https://raw.githubusercontent.com/deeniedoank/autoscript2/master/menu/userlimitssh.sh"
#mv ./userlimitssh.sh /usr/bin/userlimitssh.sh
#chmod +x /usr/bin/userlimitssh.sh

# cranjob
sudo apt-get install cron
wget https://raw.githubusercontent.com/deeniedoank/autoscript2/master/clearcache/crontab
mv crontab /etc/
chmod 644 /etc/crontab

# tool 
wget -O userlimit.sh "https://raw.githubusercontent.com/deeniedoank/autoscript2/master/menu/userlimit.sh"
wget -O userexpired.sh "https://raw.githubusercontent.com/deeniedoank/autoscript2/master/menu/userexpired.sh"
wget -O autokill.sh "https://raw.githubusercontent.com/deeniedoank/autoscript2/master/menu/autokill.sh"
wget -O userlimitssh.sh "https://raw.githubusercontent.com/deeniedoank/autoscript2/master/menu/userlimitssh.sh"
echo "@reboot root /root/userexpired.sh" > /etc/cron.d/userexpired
echo "@reboot root /root/userlimit.sh" > /etc/cron.d/userlimit
echo "@reboot root /root/userlimitssh.sh" > /etc/cron.d/userlimitssh
echo "@reboot root /root/autokill.sh" > /etc/cron.d/autokill
sed -i '$ i\screen -AmdS check /root/autokill.sh' /etc/rc.local
chmod +x userexpired.sh
chmod +x userlimit.sh
chmod +x autokill.sh
chmod +x userlimitssh.sh

# install vnstat gui
apt-get install vnstat
cd /home/vps/public_html/
wget http://www.sqweek.com/sqweek/files/vnstat_php_frontend-1.5.1.tar.gz
tar xf vnstat_php_frontend-1.5.1.tar.gz
rm vnstat_php_frontend-1.5.1.tar.gz
mv vnstat_php_frontend-1.5.1 vnstat
cd vnstat
sed -i "s/eth0/venet0/g" config.php
sed -i "s/\$iface_list = array('venet0', 'sixxs');/\$iface_list = array('venet0');/g" config.php
sed -i "s/\$language = 'nl';/\$language = 'en';/g" config.php
sed -i "s/Internal/Internet/g" config.php
sed -i "/SixXS IPv6/d" config.php
# setting vnstat
#vnstat -u -i venet0
service vnstat restart

# user-list
#cd
#wget "https://raw.githubusercontent.com/deeniedoank/autoscript2/master/menu/user-list"
#mv ./user-list /usr/local/bin/user-list
#chmod +x /usr/local/bin/user-list


# Install Monitor
#cd
#wget "https://raw.githubusercontent.com/deeniedoank/autoscript2/master/menu/monssh"
#mv monssh /usr/local/bin/
#chmod +x /usr/local/bin/monssh

# antiddos
wget https://raw.githubusercontent.com/deeniedoank/autoscript2/master/antiddos/install.sh
chmod 700 install.sh
./install.sh

# clear cache
wget https://raw.githubusercontent.com/deeniedoank/autoscript2/master/clearcache/clearcache.sh
mv clearcache.sh /root/
chmod 755 /root/clearcache.sh

# buka port 80
iptables -I INPUT -p tcp --dport 80 -j ACCEPT


# speedtest
cd
apt-get install python
wget -O speedtest.py "https://raw.githubusercontent.com/deeniedoank/autoscript2/master/menu/speedtest.py"
chmod +x speedtest.py

# Install Menu
cd
wget "https://raw.githubusercontent.com/deeniedoank/autoscript2/master/menu/menu"
mv ./menu /usr/local/bin/menu
chmod +x /usr/local/bin/menu

# moth
cd
wget "https://raw.githubusercontent.com/deeniedoank/autoscript2/master/menu/motd"
mv ./motd /etc/motd

# swap ram
dd if=/dev/zero of=/swapfile bs=1024 count=1024k
# buat swap
mkswap /swapfile
# jalan swapfile
swapon /swapfile
#auto star saat reboot
wget https://raw.githubusercontent.com/deeniedoank/autoscript2/master/ram/fstab
mv ./fstab /etc/fstab
chmod 644 /etc/fstab
sysctl vm.swappiness=50
#permission swapfile
chown root:root /swapfile 
chmod 0600 /swapfile

echo "UPDATE AND INSTALL COMPLETE COMPLETE 99% BE PATIENT"
rm $0;rm *.txt;rm *.tar;rm *.deb;rm *.asc
clear
service cron restart
service vnstat restart
service openvpn restart
service squid3 restart
service ssh restart
service webmin restart
service dropbear restart
service nginx start
rm debian7x64.sh
rm /root/debian7x64.sh

#clear
echo "========================================"  
echo "Service Autoscript VPS Yusuf Ardiansyah" | lolcat 
echo "----------------------------------------" | lolcat
echo ""  | tee -a log-install.txt
echo "Webmin   : http://$myip:10000/" | lolcat
echo "Squid3   : 8080" | lolcat
echo "OpenSSH  : 22, 80" | lolcat
echo "Dropbear : 443, 109"| lolcat
echo "OpenVPN  : TCP Port 55 (client config : http://$myip:8090/client.tar)" | lolcat
echo "Timezone : Asia/Jakarta"| lolcat
echo "Fail2Ban : [on]"| lolcat
echo "Power By : Yusuf Ardiansyah"| lolcat
echo "PIN BBM  : yu-suf " | lolcat
echo "Telegram : e-Server"| lolcat
echo "Auto kill multy login maximal login 2"  | lolcat
echo "Tambahan Script: Otomatis Reboot 24 Jam sekali" | lolcat
echo "----------------------------------------"| lolcat
echo "LOG INSTALL  --> /root/log-install.txt"| lolcat
echo "----------------------------------------"| lolcat
echo " CREATED BY YUSUF ARDIANSYAH - JUAL AKUN SSH - VPS - SCRIPT INSTALLER PREMIUM"| lolcat
echo "========================================"  | tee -a log-install.txt
echo "      SILAHKAN REBOOT VPS ANDA !" | lolcat
echo "========================================"  | tee -a log-install.txt
cat /dev/null > ~/.bash_history && history -c
