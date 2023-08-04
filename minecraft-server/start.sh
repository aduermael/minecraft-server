#!/bin/bash

# Default version: 1.20.1
# Can be overriten passing 2 parameters
# 1: memory limit, 2: server version
version="1.20.1"
if [ -n "$2" ]
then
	version="$2"
fi

curl https://launchermeta.mojang.com/mc/game/version_manifest.json > version_manifest.json

cat version_manifest.json | jq -r ".versions | .[] | select(.id==\"$version\") | .url" > server_manifest_url

curl $(cat server_manifest_url) > server_manifest.json

cat server_manifest.json | jq -r .downloads.server.url > server_url

curl $(cat server_url) -o "/data/minecraft_server.${version}.jar"

if [ ! -f /data/eula.txt ]
then
    echo "eula=true" > /data/eula.txt
fi

cd /data/; java -Xmx$1 -Xms$1 -jar "minecraft_server.${version}.jar" nogui