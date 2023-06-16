#!/bin/ash
cd /home/container

echo "Installation started..."
git clone https://github.com/rathena/rathena.git .
./configure --enable-packetver=20220406
make clean
make server
chmod a+x login-server && chmod a+x char-server && chmod a+x map-server

echo "Installation finished..."
exit