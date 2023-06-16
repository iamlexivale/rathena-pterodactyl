#
# Copyright (c) 2023 Khisab Kurniawan
#

FROM        --platform=$TARGETOS/$TARGETARCH alpine:latest

LABEL       author="Carlos Milán Figueredo" maintainer="Khisab Kurniawan" 

RUN         apk update \
            && adduser -D -h /home/container container \
            && apk add --no-cache git make gcc g++ mariadb-dev mariadb-client zlib-dev pcre pcre-dev libstdc++ dos2unix mysql-client bind-tools linux-headers

USER 		container
ENV  		USER=container HOME=/home/container
WORKDIR 	/home/container

COPY        ./entrypoint.sh /entrypoint.sh
CMD         [ "/bin/bash", "/entrypoint.sh" ]