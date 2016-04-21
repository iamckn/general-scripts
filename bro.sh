#!/bin/sh

echo -e "Installing dependencies"
apt-­get install cmake make gcc g++ flex bison libpcap-­dev libssl­-dev python­-dev swig zlib1g­-dev libmagic-­dev libgeoip­-dev libelf­-dev libpcap-dev

echo -e "Setting up GeoIP"

cd /usr/share/GeoIP/
wget http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz
wget http://geolite.maxmind.com/download/geoip/database/GeoLiteCityv6-beta/GeoLiteCityv6.dat.gz
wget http://download.maxmind.com/download/geoip/database/asnum/GeoIPASNum.dat.gz
wget http://download.maxmind.com/download/geoip/database/asnum/GeoIPASNumv6.dat.gz

gunzip GeoLiteCity.dat.gz
gunzip GeoLiteCityv6.dat.gz
gunzip GeoIPASNum.dat.gz 
gunzip GeoIPASNumv6.dat.gz

ln ­-s /usr/share/GeoIP/GeoLiteCity.dat /usr/share/GeoIP/GeoIPCity.dat
ln ­-s /usr/share/GeoIP/GeoLiteCityv6.dat /usr/share/GeoIP/GeoIPCityv6.dat 

echo -e "Downloading BRO"
mkdir ­-p /nsm/bro
cd /nsm/bro
wget https://www.bro.org/downloads/release/bro-2.4.1.tar.gz
tar -zxvf bro-2.4.1.tar.gz 
rm bro-2.4.1.tar.gz
cd bro-2.4.1/

echo -e "Configuring BRO"
./configure --prefix=/nsm/bro

echo -e "Making BRO...This will take about 30 minutes"
make

echo -e "Installing BRO"
make install

echo -e "Configuring BRO"
echo 'export PATH="$PATH=:/nsm/bro/bin"' >> ~/.bashrc
wget https://dl.dropboxusercontent.com/s/0h0ae55bmf3pdq6/bro_configs.zip
unzip bro_configs.zip
rm bro_configs.zip
cp bro_configs/node-wlan0.cfg.txt /nsm/bro/etc/node.cfg
cp bro_configs/networks-all.cfg.txt /nsm/bro/etc/networks.cfg

echo -e "Everything is now set up"
echo -e "Now run.../nsm/bro/bin/broctl"
echo -e "Then type install followed by start"
echo -e "Type status to confirm Bro is running then stop"
