#!/bin/sh

ensure_cron_entry() {
    ENTRY="$1"

    if crontab -u "$USER" -l 2>/dev/null | grep -Fx "$ENTRY" > /dev/null; then
        echo "Crontab entry already exists: $ENTRY"
    else
        (crontab -u "$USER" -l 2>/dev/null; echo "$ENTRY") | crontab -u "$USER" -
        echo "Crontab entry added: $ENTRY"
    fi
}

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
ensure_cron_entry "*/5 * * * * cd $(pwd) && . .env && ./mrtg.sh && /usr/bin/curl -fsS -m 10 --retry 5 -o /dev/null \$HOSTCHECK > /tmp/mrtg.log 2>&1"
# this doesn't work so well... it needs sudi
#ensure_cron_entry "*/15 * * * * cd $(pwd) && ./build.sh > /tmp/build.log 2>&1"

chmod +x mrtg.sh
chmod +x build.sh

