#!/usr/bin/env python3
import httplib2
from urllib.parse import urlencode
import xml.etree.ElementTree as etree

#httplib2.debuglevel = 1 # debugging on

h = httplib2.Http('.cache') # use cache directory in current folder

feed_url = 'https://www.google.com/reader/api/0/unread-count?%s'
params = {'all':'true', 'output':'xml'}
#payload =  {'api_key':'ff66eb04a2397fa3c1c031d2150cc3e7',
                                                                #'secret':'447000371cdaf272dfe96f134629def4',
                                                                #'method':'user.getRecentTracks',
                                                                #'method':'user.getInfo',
                                                                #'user':'lordmansfeld',
                                                                #'limit':'5' # only request the last 5 tracks
                                                                #}

# credentials : not needed for last.fm
h.add_credentials('andrewwwatson','OBFUSCATETHIS','www.google.com')

response, content = h.request(feed_url, 'GET', urlencode(params))

print(response)
print(content.decode('utf-8'))
tree = etree.fromstring(content) # tree is an XML object

#atom = "{http://purl.org/atom/ns#}"

#unreadcount = tree.findtext("{http://purl.org/atom/ns#}fullcount")
#new_mails = tree.findall("{http://purl.org/atom/ns#}entry")
#mail_dict = []
#
#for mail in new_mails:
#       m = {}
#       m['title'] = mail.findtext(atom+"title")
#       m['summary'] = mail.findtext(atom+"summary")
#       m['authorname'] = mail.find(atom+"author").findtext(atom+"name")
#       m['authormail'] = mail.find(atom+"author").findtext(atom+"email")
#       mail_dict.append(m)
#
#
#print(unreadcount)
#[print("{:20} ({:25}) | {} ".format(m['authorname'], m['authormail'], m['title'],)) for m in mail_dict]


