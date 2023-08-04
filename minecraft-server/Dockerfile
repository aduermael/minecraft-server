FROM eclipse-temurin:17-jre-focal

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install jq curl -y

ADD ./start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 25565

ENTRYPOINT ["/start.sh"]
CMD ["2G", "1.10.2"]