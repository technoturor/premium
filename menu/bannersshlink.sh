#replace sshd_config
#sed -i `s/#Banner/Banner` /etc/ssh/sshd_config
sed -i 's//etc/issue.net/Banner /etc/bannerssh' /etc/ssh/sshd_config

#replace banner dropbear
sed -i 's/DROPBEAR_BANNER=/DROPBEAR_BANNER="/etc/bannerssh"/g' /etc/default/dropbear

# bannerssh
wget "https://raw.githubusercontent.com/deeniedoank/autoscript2/master/menu/bannerssh"
mv ./bannerssh /etc/bannerssh
chmod 0644 /etc/bannerssh
