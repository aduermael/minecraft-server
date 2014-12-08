#!/bin/bash

if [ -d "/minecraft-data/$1" ]
	then 
		cd /minecraft-data/${1}
		ls | grep -v 'world' | grep -v 'whitelist.sqlite' | grep -v 'banlist.sqlite' | grep -v 'favicon.png' | grep -v 'webadmin.ini' | grep -v 'settings.ini' | grep -v 'logs' | xargs rm -r
	else
		mkdir /minecraft-data/${1}
		cd /minecraft-data/${1}
	fi

cp -r /MCServer/* /minecraft-data/${1}/
rm -r /MCServer

if [ -f "/minecraft-data/$1/webadmin.ini" ]
	then
		echo "webadmin.ini is already there."
	else
		echo "create webadmin.ini"
		mv /srv/webadmin.ini /minecraft-data/${1}
	fi
	

/bin/bash