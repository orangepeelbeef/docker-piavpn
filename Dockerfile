FROM ubuntu:16.04
MAINTAINER "OJ LaBoeuf <orangepeelbeef@gmail.com>"

ENV DEBIAN_FRONTEND noninteractive

VOLUME ["/app/deluge","/torrents"]
EXPOSE 8112 1080 3128
CMD ["/app/start.sh"]

RUN echo "APT::Install-Recommends 0;" >> /etc/apt/apt.conf.d/01norecommends &&\
    echo "APT::Install-Suggests 0;" >> /etc/apt/apt.conf.d/01norecommends &&\
    apt-get update &&\
    apt-get install -qy iproute2 openvpn dante-server deluged deluge-web deluge-console runit curl ca-certificates squid&&\
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD config/sockd/sockd.conf /etc/
ADD config/openvpn/ /etc/openvpn/
ADD config/squid/ /etc/squid/
ADD service/ /etc/service/
ADD app/ /app/
