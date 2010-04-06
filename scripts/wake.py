#!/usr/bin/env python3
# wake on lan various clients
# TODO : parse args[]
# TODO : when feeling adventurous, ssh through loki to send command :)
import subprocess

# replace this by whichever machine is to be woken
wake_client = 'yggdrasil'

# list of hardware addresses on local network
clients = {
    'heimdall':'00:24:1D:CF:94:B9',
    'loki':'00:30:1b:1e:4f:e9',
    'einherjar':'00:17:31:a4:e6:6a', 
    'yggdrasil':'00:1F:E2:03:40:E2',
    }

subprocess.getoutput('/usr/bin/wol ' + clients[wake_client])

