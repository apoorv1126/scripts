#!/bin/bash
#Here below we have two ways to ping renge of hosts, 
#first script to show up and down both hosts
#Second only up hosts

#First script to show up and down hosts
for ip in 10.11.1.{1..254};do
	ping -c 1 -t 1 $ip > /dev/null 
	if [ $? -eq 0 ]; then
		echo "$ip is up"
	else
		echo "$ip is down"
	fi
done

#Second script only to show up host

echo "script for only up host"

for ip in 10.11.1.{1..254}; do ping -c 1 -t 1 $ip > /dev/null && echo "${ip} is up"; done
