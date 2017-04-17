#sed -i 's/#Banner/Banner' etc/ssh/sshd_config
#sed -i 's/issue.net/bannerssh' /etc/ssh/sshd_config

#replace banner dropbear
sed -i 's/DROPBEAR_BANNER=""/DROPBEAR_BANNER="bannerssh"/g' /etc/default/dropbear

# bannerssh
wget "https://raw.githubusercontent.com/deeniedoank/autoscript2/master/menu/bannerssh"
mv ./bannerssh /bannerssh
chmod 0644 /bannerssh
