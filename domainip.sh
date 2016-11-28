#!/bin/bash
#this scrit is to extract the ip from the list of domain names
for url in $(cat cisco.txt);do
	host $url | grep "has address" | cut -d" " -f4
done
