#!/bin/sh

CONF=mrtg.conf

echo "WorkDir: /var/www/html/mrtg/" > $CONF

rm _tmp*.sh
while IFS=: read -r action host; do
	# Present action and host
	KEY=${action}_$(echo "${host}" | sed "s/\./_/g")
	FILE=_tmp_${KEY}.sh
	
	cat ${action}.sh | sed "s/%HOST%/$host/g" > $FILE
	chmod +x $FILE

	cat ${action}.mrtg | sed "s/%HOST%/$host/g" | sed "s/%KEY%/$KEY/g" | sed "s/%FILE%/$FILE/g" >> $CONF
done  < config.txt

indexmaker mrtg.conf --output /var/www/html/mrtg/index.html
