#!/usr/bin/env bash

# Install cron
yum -y install cronie

# Add /root/sysinfo.sh script
cat <<EOF >>/root/sysinfo.sh
#!/usr/bin/env bash

# A simple logger
echo "==========================="
date
echo "==========================="
w
echo "==========================="
free -m
echo "==========================="
df -h
echo "==========================="
ss -tulpn
echo "==========================="
ping -c1 -w1 ukr.net
echo "==========================="
find / -perm -4000 -print
echo "###########################"
EOF

# Make sysinfo.sh executable
chmod +x /root/sysinfo.sh

# Configure the schedule
#echo "* * * * 1-5 /root/sysinfo.sh >> /var/log/sysinfo" | crontab -
echo "* * * * * /root/sysinfo.sh >> /var/log/sysinfo" | crontab -

# Enable the service to be available after restart
systemctl enable crond.service

# Start the service
systemctl start crond.service
