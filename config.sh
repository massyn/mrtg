#!/bin/sh

CONF=mrtg.conf
OUTPUT=/var/www/html/mrtg/

cat mrtg.conf.orig > $CONF

rm _tmp*.sh
while IFS=: read -r action host; do
	# Present action and host
	KEY=${action}_$(echo "${host}" | sed "s/\./_/g")
	FILE=_tmp_${KEY}.sh
	
	cat ${action}.sh | sed "s/%HOST%/$host/g" > $FILE
	chmod +x $FILE

	cat ${action}.mrtg | sed "s/%HOST%/$host/g" | sed "s/%KEY%/$KEY/g" | sed "s/%FILE%/$FILE/g" >> $CONF
done  < config.txt

indexmaker mrtg.conf --output ${OUTPUT}index.html

sed -i "/<HEAD>/a <link rel=\"stylesheet\" type=\"text/css\" href=\"style.css\">" ${OUTPUT}/index.html
cp style.css $OUTPUT
