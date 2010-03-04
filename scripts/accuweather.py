#!/usr/bin/env python3
import httplib2
from urllib.parse import urlencode
import xml.etree.ElementTree as etree

#httplib2.debuglevel = 1 # debugging on

h = httplib2.Http('.cache') # use cache directory in current folder

root_url = 'http://rss.accuweather.com/rss/liveweather_rss.asp?metric=1&locCode=EUR|CH|SZ024|OLLON'
#payload =  {'api_key':'ff66eb04a2397fa3c1c031d2150cc3e7',
				#'secret':'447000371cdaf272dfe96f134629def4',
				#'method':'user.getRecentTracks',
				#'method':'user.getInfo',
				#'user':'lordmansfeld',
				#'limit':'5' # only request the last 5 tracks
				#}

# credentials : not needed for last.fm
#h.add_credentials('lordmansfeld','PASSWORD','last.fm')

response, content = h.request(root_url, 'GET', #urlencode(payload),
																																								)

#print(content.decode('utf-8'))
tree = etree.fromstring(content) # tree is an XML object
#print(response)
#print(content)

#user = tree[0] # extract subtree user, contains user info fields :)

# debug info : pretty print all fields
current = tree[0][8].findtext('title').replace('Currently: ','')

description, temp = current.split(': ')

#print(description, "in Ollon, temperature :", temp.replace('C','°C'))
print(temp.replace('C',''))
print(description)

# construct a neat sentence with some interesting information


