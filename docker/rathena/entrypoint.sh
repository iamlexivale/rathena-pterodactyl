#!/bin/ash
cd /home/container

echo "Initalizing Docker container..."
git clone https://github.com/rathena/rathena.git .
./configure --enable-packetver=${PACKETVER}
make clean
make server
chmod a+x login-server && chmod a+x char-server && chmod a+x map-server 