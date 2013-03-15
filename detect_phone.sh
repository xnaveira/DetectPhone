#!/bin/bash
# author: Vasilis.Vlachoudis@cern.ch
# date: 15 Mar 2013
# modified by: xnaveira ##*at*$$ gmail.com
# This is a modified version for XFCE

BTHW="xx:xx:xx:xx:xx:xx"  # Enter your Phone Bluetooth hardware address
LOCKPRG="xscreensaver"		# Screen saver program
LOCKCOMMAND="xscreensaver-command -lock"
STATUSCOMMAND="xscreensaver-command -time"
SLEEP=5
PID=$(pgrep -u $USER $LOCKPRG | head -1)

ME=`whoami`
while true
do	
	# Ping the phone (needs sudo permissions
	# chmod u+s /usr/bin/l2ping
	l2ping -t 5 -c 1 $BTHW >/dev/null 2>/dev/null
	RC=$?
	if [ $RC = 0 ]; then
		# Phone present...
                STATUS=$($STATUSCOMMAND)
                if [[ "$STATUS" == *locked* ]]; then #kill only if the screen is locked
		    kill -HUP $PID
		    xset dpms force on
                fi
        else # Phone not present
                $LOCKCOMMAND
	fi
	sleep $SLEEP
done
