#!/bin/bash

#Temporary sets ACCEPT as the default policy for INPUT and OUTPUT
iptables --policy INPUT ACCEPT
iptables --policy OUTPUT ACCEPT

#Deletes all current rules
iptables -F INPUT
iptables -F FORWARD
iptables -F OUTPUT

#Accepts tcp on the following ports
for port in 53; do
	iptables -A INPUT -p tcp --dport $port -j ACCEPT
	iptables -A OUTPUT -p tcp --sport $port -j ACCEPT
done

#Accepts udp on the following ports
for port in 22 25 80 443 3306; do
	iptables -A INPUT -p tcp --dport $port -j ACCEPT
	iptables -A OUTPUT -p tcp --sport $port -j ACCEPT
done

#Sets the default policy for everything else to DROP
iptables --policy INPUT DROP
iptables --policy FORWARD DROP
iptables --policy OUTPUT DROP

#Show results
iptables -L -v
