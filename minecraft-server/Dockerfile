FROM ubuntu:13.04

RUN apt-get install -y python-software-properties
RUN apt-get install -y software-properties-common

RUN apt-get install -y openjdk-7-jdk

ADD https://s3.amazonaws.com/Minecraft.Download/versions/1.8/minecraft_server.1.8.jar /srv/minecraft_server.jar
ADD start.sh /srv/start.sh

WORKDIR /minecraft-data
EXPOSE 25565

ENTRYPOINT ["/bin/bash","/srv/start.sh"]

CMD ["java -Xms1G -Xmx1G -jar minecraft_server.jar nogui"]