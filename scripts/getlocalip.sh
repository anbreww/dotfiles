#!/bin/bash
# get local IP address
ifconfig|grep 'inet'|sed -n -e 's/.*inet //' -e 's/ .*$//p' | grep -v '127.0.0.1' || echo "not connected"
