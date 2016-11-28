#/bin/bash
sed -n "/cisco.com/p" index.html | cut -d"/" -f3 | cut -d'"' -f1 | sort -u | grep "cisco.com"
#below is the another command doing the same thing : Given in OSCP example
grep "href=" index.html | cut -d "/" -f 3 | grep "\." | cut -d '"' -f 1 | sort -u
#another way of doing it using regular expression
grep -o '[A-Za-z0-9_\.-]*\.*cisco.com' index.html | sort -u
