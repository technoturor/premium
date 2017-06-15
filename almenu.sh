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

echo "Selesai...!!!";
