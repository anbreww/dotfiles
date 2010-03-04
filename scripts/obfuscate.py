#!/usr/bin/python3
# Obfuscate.py - store a password in a text file in base64 encoding
# This method is NOT secure (very easy to reverse-engineer) but does prevent
# casual viewers from glancing at a password in the source code.
# Also, it's good to keep passwords in an UNVERSIONED file :)

# Usage : obfuscate.py accountname newpassword

import base64
import sys
import os

# file to store passwords in
passwordfile = ".obfscpw"


if len(sys.argv) > 2:
		account = sys.argv[1]
		password = sys.argv[2]
else:
		sys.exit("Usage : {} accountname newpassword".format(sys.argv[0]))


obfuscatedpassword = base64.b64encode(password.encode("utf-8")).decode("utf-8")

#print("{}\t{}\n".format(account,obfuscatedpassword))

# load current passwords into a dictionary
pwdict = {}

if os.path.isfile(passwordfile):
	with open(passwordfile, encoding='utf-8') as pwfile:
		lines = pwfile.readlines()
	pwdict = dict([l.strip().split('\t') for l in lines])


#print(pwdict)

# update (or add) password for given account
pwdict[account] = obfuscatedpassword

#print(pwdict)

# write updated list to password file
with open(passwordfile, mode='w', encoding='utf-8') as pwfile:
		for accountname, obfpw in pwdict.items():
				pwfile.write("{}\t{}\n".format(accountname, obfpw))

