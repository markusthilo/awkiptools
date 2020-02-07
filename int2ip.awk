#!/bin/awk
#
# parse an integer encoded IPv4 to point separated 8 bit decimals
# usage: cat ips.list | gawk -f ip2int2ip.awk
# example: 3232235777 -> 192.168.1.1

# written by Markus Thilo, October 2015, GPL

{
	dec = $0
	ip = ""
	delimiter = ""
	for ( e = 3; e >= 0; e--){
		octet = int( dec / (256 ^ e) )
		dec -= octet * ( 256 ^ e )
		ip = ip delimiter octet
		delimiter = "."
	}
	print ip
}
