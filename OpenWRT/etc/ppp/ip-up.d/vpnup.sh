#!/bin/sh
VPN_DEV=$(ifconfig | grep "pptp" | sed -e "s#^\([^ ]*\) .*#\1#g")
VPN_GW=$(ip route show dev $VPN_DEV | tail -n 1 |cut -d ' ' -f 1)
ip route add 8.8.8.8 dev $VPN_DEV
ip route add 8.8.4.4 dev $VPN_DEV
ip route add 208.67.222.222 dev $VPN_DEV
ip route add 208.67.220.220 dev $VPN_DEV
ip route add default via $VPN_GW table 1
ip rule add fwmark 1 table 1
/etc/init.d/dnsmasq restart
