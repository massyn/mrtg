#!/bin/sh
HOST=%HOST%
COUNT=10
DTE=$(date '+%Y-%m-%d %H:%M:%S')
VAR=$(ping $HOST -c $COUNT | tail -1 | cut -d \/ -f 5)
echo $VAR
echo $VAR
uptime -s
echo $HOST
