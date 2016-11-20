#!/bin/bash

i=0
# default delay between map renderings
delay=1h
apikey=""

rm ./config
cp ./config-initial ./config

echo "renderers:"

for var in "$@"
do
	# first parameter: delay between each map rendering
	if (( $i == 0 ))
	then
		delay=$var
		i=$((i+1))

	# rendering options
	else
		if [[ $var == "day" ]]
		then
			echo "- daytime"
			printf "\n\nrenders[\"Day\"] = {\"world\": \"Minecraft world\", \"title\": \"Daytime\", \"rendermode\": smooth_lighting, \"dimension\": \"overworld\",\"markers\": [dict(name=\"Signs\", filterFunction=signFilter), dict(name=\"Players\", filterFunction=playerIcons)]}" >> ./config
			i=$((i+1))

		elif [[ $var == "night" ]]
		then
			echo "- nighttime"
			printf "\n\nrenders[\"Night\"] = {\"world\": \"Minecraft world\", \"title\": \"Nighttime\", \"rendermode\": smooth_night, \"dimension\": \"overworld\",\"markers\": [dict(name=\"Signs\", filterFunction=signFilter), dict(name=\"Players\", filterFunction=playerIcons)]}" >> ./config
			i=$((i+1))

		elif [[ $var == "nether" ]]
		then
			echo "- nether"
			printf "\n\nrenders[\"Nether\"] = {\"world\": \"Minecraft world\", \"title\": \"Nether\", \"rendermode\": nether_smooth_lighting, \"dimension\": \"nether\"}" >> ./config
			i=$((i+1))

		elif [[ $var == "end" ]]
		then
			echo "- ender"
			printf "\n\nrenders[\"End\"] = {\"world\": \"Minecraft world\", \"title\": \"End\", \"rendermode\": end_lighting, \"dimension\": \"end\"}" >> ./config
			i=$((i+1))


		else
			apikey=$var
		fi
	fi
done

# default rendering options (day overworld only)
if [[ $i < 2 ]]
then
	echo "- default (daytime only)"
	printf "\n\nrenders[\"Day\"] = {\"world\": \"Minecraft world\", \"title\": \"Daytime\", \"rendermode\": smooth_lighting, \"dimension\": \"overworld\",\"markers\": [dict(name=\"Signs\", filterFunction=signFilter), dict(name=\"Players\", filterFunction=playerIcons)]}" >> ./config
fi

printf "\n\n" >> ./config

echo "delay: ""$delay"
if [[ $apikey != "" ]]
then
	echo "api key: "$apikey
fi

while true
do
	overviewer.py --config=/srv/config
	overviewer.py --config=/srv/config --genpoi

	# use Google API key if available
	if [[ $apikey != "" ]]
	then
		sed -i "s/\?sensor=false/&\&key=$apikey/g" /webmap/index.html
	fi

	sleep $delay
done
