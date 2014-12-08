#!/bin/bash

if [ -d "/minecraft-data/$1" ]
	then 
		cd /minecraft-data/${1}
		ls | grep -v 'world' | grep -v 'whitelist.sqlite' | grep -v 'banlist.sqlite' | grep -v 'favicon.png' | grep -v 'settings.ini' | grep -v 'logs' | xargs rm -r
	else
		mkdir /minecraft-data/${1}
		cd /minecraft-data/${1}
	fi

cp -r /MCServer/* /minecraft-data/${1}/
rm -r /MCServer


echo "create webadmin.ini"
mv /srv/webadmin.ini /minecraft-data/${1}/

sed "s,USER_FIELD,$2," < /minecraft-data/${1}/webadmin.ini > /minecraft-data/${1}/webadmin.ini.tmp1
sed "s,PASS_FIELD,$3," < /minecraft-data/${1}/webadmin.ini.tmp1 > /minecraft-data/${1}/webadmin.ini.tmp2

rm /minecraft-data/${1}/webadmin.ini
rm /minecraft-data/${1}/webadmin.ini.tmp1
mv /minecraft-data/${1}/webadmin.ini.tmp2 /minecraft-data/${1}/webadmin.ini

cd /minecraft-data/${1}; ./MCServer;

/bin/bash