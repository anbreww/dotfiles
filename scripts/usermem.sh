#/bin/bash
# display memory used in MB for current user
# TODO : remove sed and do it all in awk
ps -u `whoami` -o rss, | awk '{total+=$0}END{printf("%5.2f MB\n",total/1024)}'
