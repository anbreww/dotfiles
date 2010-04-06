#/bin/bash
# display memory used in MB for current user
# TODO : remove sed and do it all in awk
ps -u `whoami` -o rss,command, | sed  -n -e 's/\([0-9]\+\).*$/\1/p' | awk '{total+=$0}END{printf("%5.2f MB\n",total/1024)}'
