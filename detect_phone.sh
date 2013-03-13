#!/bin/bash
# author: Vasilis.Vlachoudis@cern.ch
# date: 13 Mar 2013
# modified by: xnaveira ##*at*$$ gmail.com
# This is a modified version for XFCE

BTHW="xx:xx:xx:xx:xx:xx"  # Enter your Phone Bluetooth hardware address
LOCKPRG="xscreensaver"		# Screen saver program
SLEEP=5

ME=`whoami`
while true
do	
        sleep 15 #give me time to run away
	# Ping the phone (needs sudo permissions
	# chmod u+s /usr/bin/l2ping
	l2ping -t 5 -c 1 $BTHW >/dev/null 2>/dev/null
	RC=$?
	if [ $RC = 0 ]; then
		# Phone present...
		pkill $LOCKPRG
                $LOCKPRG& #you want it running in the background to be able to lock the screen afterwards
		xset dpms force on
	fi
	sleep $SLEEP
done
