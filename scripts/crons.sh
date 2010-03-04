#!/bin/bash
# scripts to execute every 5 minutes from cron

# make sure cache dir exists
mkdir -p /tmp/aw_cache

# stuff to do if connection is present

if [[ $(~/scripts/check_connection) != 0 ]]; then
    # check e-mails
    ~/scripts/checkwmail.py > /tmp/aw_cache/unreadcount
    # check external IP
    # pacman -Sy less often maybe
    # get brief weather forecast
    ~/scripts/accuweather.py > /tmp/aw_cache/weathershort
fi

# stuff to do even if connection is broken
# check if loki is online (ping + ssh)
~/scripts/check_watsons > /tmp/aw_cache/loki_status

yes|pacman -Sup 2>/dev/null | sed -n -e 's/^[fh]t\+p:\/\/.*\/\(.\+\)\.pkg.tar.[xg]z/\1/p' > /tmp/aw_cache/available_updates

# check local IP
