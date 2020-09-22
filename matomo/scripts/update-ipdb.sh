#!/bin/sh

DATE=$(date +"%Y-%m")

printf "Downloading IP-DB Database for date: %s\\n" "$DATE"
wget -O geoip.gz "https://download.db-ip.com/free/dbip-city-lite-$(date +%Y-%m).mmdb.gz"
printf "Unzipping...\\n"
gunzip -c geoip.gz > /data/geoip/DBIP-City.mmdb
printf "Setting permission for DBIP-City\\n"
chown 82:82 /data/geoip/DBIP-City.mmdb
