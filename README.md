# awkiptools

AWK scripts to parse IP addresses

## int2ip.awk

Parse an integer encoded IPv4 to point separated 8 bit decimals

Usage: cat ips.list | awk -f ip2int2ip.awk

Example: 3232235777 -> 192.168.1.1

## ip2int.awk

Parse IPv4 to integer encoded decimal

Usage: cat ips.list | awk -f ip2int.awk

Example: 192.168.1.1 -> 3232235777

## ipranger.awk

Parse IPv4 in 1st field of list

Remove spaces

Remove leading 0s, example: 192.168.022.001 -> 192.168.22.1

Expand ip ranges in CIDR notatio

Skip lines without valid IP or range

Usage: cat ips.list | awk -f ipranger.awk

Example: 192.168.100.0/28 -> 192.168.100.0 \n 192.168.100.1 \n 192.168.100.2 ...
