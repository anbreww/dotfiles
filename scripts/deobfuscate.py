#!/usr/bin/python3
# deobfuscate.py : retrieve clear password from obfuscated file

# Usage : deobfuscate.py accountname

import base64
import sys,os

# file to store passwords in
passwordfile = os.path.join(sys.path[0],".obfscpw")

def deobfuscate(account):
# load current passwords into a dictionary

    try:
        with open(passwordfile, encoding='utf-8') as pwfile:
                                        lines = pwfile.readlines()
        pwdict = dict([l.strip().split('\t') for l in lines])

        obfuscatedpassword = pwdict[account]
    except KeyError:
        sys.exit("Account \'{}\' not found in password file".format(sys.argv[1]))
    except IOError:
        sys.exit("Could not read from password file")

    return base64.b64decode(obfuscatedpassword.encode("utf-8")).decode("utf-8")


if __name__ == '__main__':
    if len(sys.argv) > 1:
        account = sys.argv[1]
    else:
        sys.exit("Usage : {} accountname".format(sys.argv[0]))
    
    clearpassword = deobfuscate(account)

    print(clearpassword)
