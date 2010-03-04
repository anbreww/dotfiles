#!/usr/bin/env python3
# get e-mail from google apps

import httplib2
from urllib.parse import urlencode
import xml.etree.ElementTree as etree

import deobfuscate # custom script for loading passwords

accountname = 'wmail'
address = 'andrew@watsons.ch'

#httplib2.debuglevel = 1 # debugging on

h = httplib2.Http('.cache') # use cache directory in current folder

feed_url = 'https://mail.google.com/mail/feed/atom'

# credentials
password = deobfuscate.deobfuscate(accountname)
h.add_credentials(address, password,'mail.google.com')

response, content = h.request(feed_url, 'GET')

#print(content.decode('utf-8'))
tree = etree.fromstring(content) # tree is an XML object

atom = "{http://purl.org/atom/ns#}"

unreadcount = tree.findtext("{http://purl.org/atom/ns#}fullcount")
new_mails = tree.findall("{http://purl.org/atom/ns#}entry")
mail_dict = []

for mail in new_mails:
	m = {}
	m['title'] = mail.findtext(atom+"title")
	m['summary'] = mail.findtext(atom+"summary")
	m['authorname'] = mail.find(atom+"author").findtext(atom+"name")
	m['authormail'] = mail.find(atom+"author").findtext(atom+"email")
	mail_dict.append(m)


print(unreadcount)
#[print("{:20} ({:25}) | {} ".format(m['authorname'], m['authormail'], m['title'],)) for m in mail_dict]


