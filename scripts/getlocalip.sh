#!/bin/bash
# get local IP address
ifconfig|grep 'inet addr'|sed -n -e 's/.*addr://' -e 's/ .*$//p' | grep -v '127.0.0.1' || echo "not connected"
