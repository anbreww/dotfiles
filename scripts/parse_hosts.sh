#!/bin/bash
# parse hosts list into format for dhcpd.conf file
# only include lines that contain at least one MAC address.
# this regexp is quite rudimentary, will only match :
# hostname      ipaddress       MACADDRESS1
# where hostname is alphanumeric and separation is whitespace, not tabs!

sed -n -e 's/^\([0-9A-Za-z]*\) \+\([0-9.]\+\) \+\([0-9A-Fa-f:]\+\).*/host \1 {\n\thardware ethernet \3;\n\tfixed-address \2;\n}/p' netmap
