import subprocess
import os
with open(os.devnull, "wb") as limbo:
    for ip in xrange(1,255):
        address = "10.11.1.{0}".format(ip)
        result = subprocess.Popen(["ping", "-c", "1", address], stdout=limbo, stderr=limbo).wait()
        if result:
            print address, "is down"
        else:
            print address, "is up"
