#!/bin/bash
# get real IP address
if [[ $(/home/andrew/scripts/check_connection) != 0 ]]; then
    wget -q -O - checkip.dyndns.org|sed -e 's/.*Current IP Address: //' -e 's/<.*$//'
else
    echo "not connected"
fi
