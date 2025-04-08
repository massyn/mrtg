#!/bin/sh

# Check if the script is running with sudo
if [ "$(id -u)" -ne 0 ]; then
    echo "Script was NOT invoked with sudo."
    exit 1
fi

apt-get install mrtg -y
USER=$SUDO_USER
sudo chown -R $USER:www-data /var/www/html

# Define the crontab entry you want to check
set -f
CRON_ENTRY="* * * * * cd $(pwd) && ./mrtg.sh > /tmp/mrtg.log 2>&1"

# Check if the crontab entry already exists
(crontab -u "$USER" -l 2>/dev/null | grep -Fx "$CRON_ENTRY") > /dev/null
# $? is the exit status of the last command. If it's 0, the entry exists; if it's non-zero, it doesn't.
if [ $? -ne 0 ]; then
    # Add the crontab entry if it doesn't exist
    (crontab -u "$USER" -l 2>/dev/null; echo "$CRON_ENTRY") | crontab -u "$USER" -
    echo "Crontab entry added."
else
    echo "Crontab entry already exists."
fi

chmod +x mrtg.sh

