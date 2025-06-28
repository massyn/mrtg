#!/bin/sh

folder=$(dirname $0)
if [ "$folder" != "." ]; then
	cd $folder
fi

. $folder/.env
echo $HOSTCHECK
./mrtg.sh && /usr/bin/curl -fsS -m 10 --retry 5 -o /dev/null $HOSTCHECK
