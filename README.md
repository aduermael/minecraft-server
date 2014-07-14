minecraft_server
================

A simple (& pluggable) Minecraft server. 

No data is store on the Minecraft server container. 
You'll need to use **aduermael/minecraft-data** as well to run the server. 

### Pull the 2 images:
```
docker pull aduermael/aduermael/minecraft-data
docker pull aduermael/minecraft-server
```
### Run the 2 containers (in that same order):
```
docker run --name MCDATA aduermael/minecraft-data
docker run -d -p 25565:25565 --volumes-from MCDATA aduermael/minecraft-server
```

You're good to go and play Minecraft with your friends! :)

### Optionally you can run your server with a custom command such as:

```
docker run -t -i -p 25565:25565 --volumes-from MCDATA aduermael/minecraft-server java -Xms1536M -Xmx2560M -jar minecraft_server.jar
```

### More...

You can use 2 other images I did to display a map of your Minecraft world in a web browser:

### Pull 2 more images:
```
docker pull aduermael/minecraft-webmap
docker pull aduermael/minecraft-webmap-generator
```

### Run the web server
```
docker run -d -p 80:80 --name MCWEBMAP aduermael/minecraft-webmap
```

### Run the map generator
```
docker run --volumes-from MCDATA --volumes-from MCWEBMAP aduermael/minecraft-webmap-generator
```

You can run that container every day, or hourly by setting a cron task. 

```
@daily docker run --volumes-from MCDATA --volumes-from MCWEBMAP aduermael/minecraft-webmap-generator
```

[@a_duermael][2]


  [1]: https://twitter.com/gaetan_dv
  [2]: https://twitter.com/aduermael
