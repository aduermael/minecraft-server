Dockerized Minecraft server
================

A set of containers to run a Minecraft server, store generated data, and generate a world webmap.

## Quick setup

#### Step 1: create a volume to store generated data

```shell
docker volume create --name minecraft-data
```

#### Step 2: run the Minecraft server!

```shell
docker run -ti -d -v minecraft-data:/data --name minecraft-server \
-p 25565:25565 aduermael/minecraft-server 
```

Tadam! You now have a `1.10.2` Minecraft server running that will use up to `2G` of RAM.

## More options

You can easily configure your server with a few options if needed.

#### Step 1: stop & remove your running container

```shell
docker stop minecraft-server
docker rm minecraft-server
```

#### Step 2: re-run with more options

```shell
# -ti gives you interactivity if you want to attach
# -d makes it run in detached mode
# --restart=always will make it restart automatically
# --memory=1600M limits memory usage
# -v minecraft-data:/data mounts the data volume
# --name minecraft-server gives it a name
# -p 25565:25565 exposes on default Minecraft server port
# 1536M is the max amount of memory allocated by the server
# 1.10.2 is the version of Minecraft server that you want to use
docker run -ti -d --restart=always --memory=1600M \
-v minecraft-data:/data --name minecraft-server \
-p 25565:25565 aduermael/minecraft-server 1536M 1.10.2
```
Minecraft server versions are listed here: [https://mcversions.net](https://mcversions.net)

**Note:** if you use the same volume, you'll see that all your generated data has been preserved.

## Admin console

You can attach in the admin console typing that command:

```shell
docker attach minecraft-server
# (you may have to type "enter" then to display first line)
```

Use the escape sequence `Ctrl` + `p` + `Ctrl` + `q` to detach.

[List of admin commands](http://minecraft.gamepedia.com/Commands)


## Generate a world webmap

#### Step 1: run web server Docker container

```shell
docker run -d -p 80:80 --name minecraft-map aduermael/minecraft-map
```

If you enter the server IP in a web browser, you should see that message: `Minecraft webmap has not been generated yet.`, because the data hasn't been generated yet. 

#### Step 2: generate data for the web server

```shell
docker run --rm -v minecraft-data:/data \
--volumes-from minecraft-map aduermael/minecraft-map-gen
```

This container generates the world map data then exits (can take time depending on the size of your map). You can now refresh the page in your browser and see the map! :)

![screen shot 2016-06-30 at 5 36 57 pm](https://cloud.githubusercontent.com/assets/6775074/16508651/ea1b5d78-3ee9-11e6-8627-5239ec6b3556.png)

You can run that container from time to time manually. Or schedule it with a cron task:

```shell
@daily docker run --rm -v minecraft-data:/data \
--volumes-from minecraft-map aduermael/minecraft-map-gen
```

[@aduermael](https://twitter.com/aduermael)
