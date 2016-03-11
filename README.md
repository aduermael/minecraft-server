Dockerized Minecraft server
================

A set of containers to run a Minecraft server, store generated data, and generate a world webmap.

### Quick setup

#### Step 1: pull Docker images

```shell
# Simple volume container to store generated data
docker pull aduermael/minecraft-data
# The Minecraft server
docker pull aduermael/minecraft-server
```

#### Step 2: run Docker containers

```shell
docker run --name minecraft-data minecraft-data

# Run Minecraft server container on default port
# with some options:
# -ti gives you interactivity if you want to attach
# -d makes it run in detached mode
# --restart=always will make it restart automatically
# --memory=1600M limits memory usage
# --volumes-from minecraft-data mounts the data volume
# --name minecraft-server gives it a name
# -p 25565:25565 exposes on default Minecraft server port
# 1536M is the max amount of memory allocated by the server
# 1.9 is the version of the server you want to deploy
docker run -ti -d --restart=always --memory=1600M \
--volumes-from minecraft-data --name minecraft-server \
-p 25565:25565 aduermael/minecraft-server 1536M 1.9
```

That's it! Now go play Minecraft! :)

### Generate a world webmap

#### Step 1: pull Docker images

```shell
# A web server that shows a webmap
docker pull aduermael/minecraft-webmap
# That one generates data for the web server
docker pull aduermael/minecraft-webmap-generator
```

#### Step 2: run web server Docker container

```shell
docker run -d -p 80:80 --name minecraft-webmap aduermael/minecraft-webmap
```

If you enter the server IP in a web browser, you should see that message: `Minecraft webmap has not been generated yet.`, because the data hasn't been generated yet. 

#### Step 3: generate data for the web server

```shell
docker run --volumes-from minecraft-data \
--volumes-from minecraft-webmap aduermael/minecraft-webmap-generator
```

This container generates the world map data then exits (can take time depending on the size of your map). You can now refresh the page in your browser and see the map! :)

You can run that container from time to time manually. Or schedule it with a cron task:

```shell
@daily docker run --volumes-from minecraft-data \
--volumes-from minecraft-webmap aduermael/minecraft-webmap-generator
```

[@aduermael](https://twitter.com/aduermael)