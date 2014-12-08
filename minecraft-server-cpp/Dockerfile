FROM ubuntu:14.04

RUN apt-get update -y
RUN apt-get install -y curl

# easyinstall in /MCServer
RUN curl -s https://raw.githubusercontent.com/mc-server/MCServer/master/easyinstall.sh | sh

ADD start.sh /srv/start.sh
ADD settings.ini /srv/settings.ini
ADD webadmin.ini /srv/webadmin.ini

# minecraft server
EXPOSE 25565

# webadmin
EXPOSE 80

# ENTRYPOINT ["/bin/bash","/srv/start.sh"]
# CMD ["java -Xms1G -Xmx1G -jar minecraft_server.jar nogui"]

ENTRYPOINT ["/bin/bash","/srv/start.sh"]
# server name
CMD ["default"]