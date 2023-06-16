FROM        --platform=$TARGETOS/$TARGETARCH alpine:latest

MAINTAINER  Khisab Kurniawan, <iamlexivale@gmail.com>

LABEL       org.opencontainers.image.source = "https://github.com/iamlexivale/docker-images-rathena-for-pterodactyl-panel"
LABEL       org.opencontainers.image.licenses=MIT

RUN         apk add --update --no-cache git make gcc g++ mariadb-dev mariadb-client zlib-dev pcre pcre-dev libstdc++ dos2unix mysql-client bind-tools linux-headers \
            && adduser --disabled-password --home /home/container container \
            && cd /home/container \
            && git clone https://github.com/rathena/rathena.git . \
            && ./configure --enable-packetver=20220406 \
            && make clean \
            && make server \
            && chmod a+x login-server && chmod a+x char-server && chmod a+x map-server

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./entrypoint.sh /entrypoint.sh
CMD         [ "/bin/ash", "/entrypoint.sh" ]