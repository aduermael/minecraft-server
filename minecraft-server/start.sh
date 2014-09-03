#!/bin/bash

mv /srv/minecraft_server.jar /minecraft-data/minecraft_server.jar

echo $@

eval "$@"

/bin/bash