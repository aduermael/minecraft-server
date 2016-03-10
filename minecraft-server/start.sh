#!/bin/bash

# Default version: 1.9
# Can be overriten passing 2 parameters
# 1: memory limit, 2: server version
version="1.9"
if [ -n "$2" ]
then
	version="$2"
fi

if [ ! -f "/data/minecraft_server.${version}.jar" ]
then
    curl "https://s3.amazonaws.com/Minecraft.Download/versions/${version}/minecraft_server.${version}.jar" -o "/data/minecraft_server.${version}.jar"
fi

if [ ! -f /data/eula.txt ]
then
    echo "eula=true" > /data/eula.txt
fi

cd /data/; java -Xmx$1 -Xms$1 -jar "minecraft_server.${version}.jar" nogui