FROM ubuntu:14.04
ENV	DEBIAN_FRONTEND noninteractive

RUN apt-get --yes update; apt-get --yes upgrade; apt-get --yes install software-properties-common
RUN sudo apt-add-repository --yes ppa:webupd8team/java; apt-get --yes update
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections  && \
    echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections  && \
    apt-get --yes install curl oracle-java8-installer

ADD ./start.sh /start.sh

RUN chmod +x /start.sh

EXPOSE 25565

ENTRYPOINT ["/start.sh"]
CMD ["2G"]