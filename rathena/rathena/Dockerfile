FROM        --platform=$TARGETOS/$TARGETARCH alpine:latest

LABEL       author="Khisab Kurniawan" maintainer="iamlexivale@gmail.com"

LABEL       org.opencontainers.image.source = "https://github.com/iamlexivale/docker-images-rathena-for-pterodactyl-panel"
LABEL       org.opencontainers.image.licenses=MIT

RUN         apk add --update --no-cache git make gcc g++ mariadb-dev mariadb-client zlib-dev pcre pcre-dev libstdc++ dos2unix mysql-client bind-tools linux-headers \
            && adduser -D -h /home/container container

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./entrypoint.sh /entrypoint.sh
CMD         [ "/bin/ash", "/entrypoint.sh" ]