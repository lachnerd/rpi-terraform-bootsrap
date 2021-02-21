#!/bin/bash
echo "========================================="
echo "Maintenance - START"
echo "========================================="
echo
echo "adding file for Docker Maintenance Job"
#Datei anlegen
touch /opt/docker-maintenance.sh
#ausführbar machen
chmod +x  /opt/docker-maintenance.sh
# log file anlegen
touch /var/log/docker-maintenance.log

echo "writing pt/docker-maintenance.sh file"
cat >/opt/docker-maintenance.sh <<EOL
#!/bin/sh
echo "`date -u` running docker-maintenance.sh"
 
# Delete all tagged images more than a week old
# (will fail to remove images still used)
docker images --no-trunc --format '{{.ID}} {{.CreatedSince}}' | grep ' weeks' | awk '{ print $1 }' | xargs --no-run-if-empty docker rmi || true
 
# remove untagged images
docker images --no-trunc | grep '<none>' | awk '{ print $3 }' | xargs -r docker rmi
EOL

echo "adding cron job"
crontab -l > file; echo '10 5 * * 1-5 /opt/docker-maintenance.sh >> /var/log/docker-maintenance.log 2>&1' >> file; crontab file

echo "empty cache ram periodically for better surveillance"
#script-datei anlegen
touch /opt/clearcache.sh
#log-datei anlegen
touch /var/log/clearcache.log
#ausführbar machen
chmod +x /opt/clearcache.sh

echo "writing /opt/clearcache.sh file"
cat >/opt/clearcache.sh <<EOL
#!/bin/sh
echo "`date -u` running clearcache.sh"
# Bash Script um Cached Memory freizugeben
sync; echo 3 > /proc/sys/vm/drop_caches
EOL

echo "adding cron job"
crontab -l > file; echo '*/15 * * * * /opt/clearcache.sh >> /var/log/clearcache.log 2>&1' >> file; crontab file

echo "restart host for security updates if needed SYS-8284"
#script-datei anlegen
touch /opt/reboot_ifrequired.sh
#log-datei anlegen
touch /var/log/reboot_ifrequired.log
#ausführbar machen
chmod +x /opt/reboot_ifrequired.sh

echo "writing /opt/reboot_ifrequired.sh file"
cat >/opt/reboot_ifrequired.sh <<EOL
#!/usr/bin/env bash
if test -f /var/run/reboot-required; then
    echo "`date -u`"
    cat /var/run/reboot-required
    echo "Following Packages will be upgraded"
    cat /var/run/reboot-required.pgks
    echo "The server restarts in 2 Minutes"
    /sbin/shutdown -r +2
fi
EOL
echo "adding cron job"
crontab -l > file; echo '15 7 * * SUN /opt/reboot_ifrequired.sh >> /var/log/reboot_ifrequired.log 2>&1' >> file; crontab file

echo "remove failed sessions older than 30 days SYS-8360"
#skript-datei anlegen
touch /opt/failedsessions_cleanup.sh
#log-datei anlegen
touch /var/log/failedsessions_cleanup.log
#ausführbar machen
chmod +x /opt/failedsessions_cleanup.sh

echo "writing /opt/failedsessions_cleanup.sh file"
cat >/opt/failedsessions_cleanup.sh <<EOL
#!/usr/bin/env bash
echo "`date -u` running failedsessions_cleanup.sh"
#Skript um failed sessions die älter als 30 Tage sind zu löschen
find /opt/insign/failedsessions/* -mtime +30 -exec rm {} \;
EOL

echo "adding cron job"
crontab -l > file; echo '15 8 * * * /opt/failedsessions_cleanup.sh >> /var/log/failedsessions_cleanup.log 2>&1' >> file; crontab file

echo "========================================="
echo "Maintenance - FINSIH"
echo "========================================="
echo