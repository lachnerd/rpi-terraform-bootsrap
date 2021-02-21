#!/bin/bash
echo "========================================="
echo "fail2ban.sh - START"
echo "========================================="
echo
echo "installing fail2ban"
apt-get -qq install fail2ban -y
echo "check fail2ban status"
/etc/init.d/fail2ban status
echo "stop fail2ban"
systemctl stop fail2ban
echo "Kopie des fail2ban Config-Files anlegen"
cp /etc/fail2ban/fail2ban.conf /etc/fail2ban/fail2ban.local

echo "writing jail.local file"
cat >/etc/fail2ban/jail.local <<EOL
#fail2ban jail file
#ignoriere locahlhost & iS2 WAN Ips
[DEFAULT]
ignoreip = 127.0.0.1/8 80.149.174.82/29
#Verbannungszeit
bantime = 3600
#Zeit die auf Funde angerechnet wird
findtime = 7200
#Fehlversuche
maxretry = 3
[sshd] enabled = true
port = 2222
EOL

echo "start fail2ban"
systemctl start fail2ban

echo "check fail2ban status"
/etc/init.d/fail2ban status
echo "========================================="
echo "fail2ban.sh - FINISH"
echo "========================================="
echo
