#!/bin/awk

# parse IPv4 to integer encoded decimal
# usage: cat ips.list | gawk -f ip2int.awk
# example: 192.168.1.1 -> 3232235777

# written by Markus Thilo, April 2016, GPL

BEGIN {	FS="." }
{
	print $1*16777216 + $2*65536 + $3*256 + $4
}
