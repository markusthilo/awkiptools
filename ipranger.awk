#!/bin/awk

# parse IPv4 in 1st field of list
# usage: cat ips.list | awk -f ipranger.awk
# - remove spaces
# - remove leading 0s, example: 192.168.022.001 -> 192.168.22.1
# - expand ip ranges in CIDR notation, example: 192.168.100.0/28 -> 192.168.100.0 \n 192.168.100.1 \n 192.168.100.2 ...
# - skip lines without valid IP or range

# written by Markus Thilo, October 2015, GPL

{
	p = gensub(/ /,"","g",$1)	# take ip from 1st field and remove spaces
	if ( gensub(/[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}/,"",1,p) == "" )	# single IP
	{
		printf gensub(/000/,"0","g",gensub(/0{1,2}([1-9])/,"\\1","g",p) )	# remove leading 0s
		i=2; while (i<=NF) printf FS $(i++)	# print rest of the line
		printf "\n"
	}
	else if ( gensub(/[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\/[0-9]{1,2}/,"",1,$1) == "" )	# range in CIDR notation
	{
		split(p,s,".")	# split IP into 4 bytes
		l = 2^(32 - gensub(/[^/]*\/(..)/,"\\1",1,$1))	# last IP of range (broadcast), variable part to be added to base IP
		b = int( ( s[1]*16777216 + s[2]*65536 + s[3]*256 + s[4] ) / l ) * l	# base IP to integer coding
		a = 0	# set start offset to 0
		while ( a++ < l-2 ) # loop from first IP to last, skip before broadcast IP
		{
			c = b+a	# add offset to base IP
			e = 16777216	# calculate xxx.xxx.xxx.xxx from integer coded IP
			for (i=1;i<=4;i++)	# loop 4 times
			{
				f[i] = int(c/e)
				c = c%e
				e = e/256
			}
			printf f[1] "." f[2] "." f[3] "." f[4]	# give single IP
			i=2; while (i<=NF) printf FS $(i++)	# print rest of the line
			printf "\n"
		}
	}
}
