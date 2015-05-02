#!/usr/bin/bash

iptables -F
iptables -X
iptables -Z

iptables -N STATE0
iptables -A STATE0 -p udp --dport 12345 -m recent --name KNOCK1 --set -j DROP
iptables -A STATE0 -j DROP

iptables -N STATE1
iptables -A STATE1 -m recent --name KNOCK1 --remove
iptables -A STATE1 -p udp --dport 23456 -m recent --name KNOCK2 --set -j DROP
iptables -A STATE1 -j STATE0

iptables -N STATE2
iptables -A STATE2 -m recent --name KNOCK2 --remove
iptables -A STATE2 -p udp --dport 34567 -m recent --name KNOCK3 --set -j DROP
iptables -A STATE2 -j STATE0

iptables -N STATE3
iptables -A STATE3 -m recent --name KNOCK3 --remove
iptables -A STATE3 -p tcp --dport 80 -j ACCEPT
iptables -A STATE3 -j STATE0

iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -s 127.0.0.0/8 -j ACCEPT
iptables -A INPUT -p icmp -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -p tcp --dport 3128 -j ACCEPT

iptables -A INPUT -m recent --name KNOCK3 --rcheck -j STATE3
iptables -A INPUT -m recent --name KNOCK2 --rcheck -j STATE2
iptables -A INPUT -m recent --name KNOCK1 --rcheck -j STATE1
iptables -A INPUT -j STATE0
