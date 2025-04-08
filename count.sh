#!/bin/sh
HOST=%HOST%
COUNT=55
DTE=$(date '+%Y-%m-%d %H:%M:%S')
VAR=$(ping $HOST -c $COUNT | grep "packets transmitted" | awk {'print $4'})
echo $VAR
echo $COUNT
uptime -s
echo $HOST
