#!/bin/bash
echo ""
echo "SELAMAT DATANG KE INSTALLER ALL MENU VPS By ntuser88"
echo ""
echo "Install aplikasi pewarna text"
# aplikasi
sudo apt-get install ruby
sudo gem install lolcat;

echo "Install file pewarna text sysrem"
# text sistem warna
cd
rm -rf .bashrc
wget https://raw.githubusercontent.com/ntuser88/allinone/master/text%20warna/.bashrc
echo "Instalasi all menu PREMIUM"

# menu
cd
wget https://raw.githubusercontent.com/ntuser88/allinone/master/menu/menu
mv ./menu /usr/local/bin/menu
chmod +x /usr/local/bin/menu

echo "Install motd"
#motd
cd
wget "https://raw.githubusercontent.com/ntuser88/allinone/master/menu/motd"
mv ./motd /etc/motd

echo "Install speedtest"
#speedtest
cd
apt-get install python
wget -O speedtest.py "https://raw.githubusercontent.com/ntuser88/allinone/master/menu/speedtest.py"
chmod +x speedtest.py

# download script
wget -O /usr/bin/autokill https://raw.githubusercontent.com/ntuser88/allinone/master/menu//autokill.sh
#wget -O /usr/bin/dropmon $source/dropmon.sh
#wget -O /usr/bin/user-active-list $source/user-active-list.sh
wget -O /usr/bin/create-user https://raw.githubusercontent.com/ntuser88/allinone/master/menu/create-user.sh
#wget -O /usr/bin/user-add-pptp $source/user-add-pptp.sh
#wget -O /usr/bin/user-del $source/user-del.sh
#wget -O /usr/bin/disable-user-expire $source/disable-user-expire.sh
#wget -O /usr/bin/delete-user-expire $source/delete-user-expire.sh
#wget -O /usr/bin/banned-user $source/banned-user.sh
wget -O /usr/bin/userexpired https://raw.githubusercontent.com/ntuser88/allinone/master/menu/userexpired.sh
#wget -O /usr/bin/user-gen $source/user-gen.sh
wget -O /usr/bin/userlimit https://raw.githubusercontent.com/ntuser88/allinone/master/menu/userlimit.sh
wget -O /usr/bin/user-list https://raw.githubusercontent.com/ntuser88/allinone/master/menu/user-list
wget -O /usr/bin/tendang https://raw.githubusercontent.com/ntuser88/allinone/master/menu/tendang
#wget -O /usr/bin/user-login $source/user-login.sh
#wget -O /usr/bin/user-pass $source/user-pass.sh
#wget -O /usr/bin/user-renew $source/user-renew.sh

chmod +x /usr/bin/autokill
#chmod +x /usr/bin/dropmon
#chmod +x /usr/bin/user-active-list
chmod +x /usr/bin/create-user
#chmod +x /usr/bin/user-add-pptp
#chmod +x /usr/bin/user-del
#chmod +x /usr/bin/disable-user-expire
#chmod +x /usr/bin/delete-user-expire
#chmod +x /usr/bin/banned-user
chmod +x /usr/bin/userexpired
#chmod +x /usr/bin/user-gen
chmod +x /usr/bin/userlimit
chmod +x /usr/bin/user-list
chmod +x /usr/bin/tendang
#chmod +x /usr/bin/user-pass
#chmod +x /usr/bin/user-renew

echo "*/30 * * * * root service dropbear restart" > /etc/cron.d/dropbear
echo "00 23 * * * root /usr/bin/disable-user-expire" > /etc/cron.d/disable-user-expire
echo "0 */12 * * * root /sbin/reboot" > /etc/cron.d/reboot
#echo "@reboot root /usr/bin/user-limit" > /etc/cron.d/userlimit
#echo "@reboot root /usr/bin/autokill" > /etc/cron.d/autokill
#sed -i '$ i\screen -AmdS check /root/autokill' /etc/rc.local

echo "Selesai...!!!";
