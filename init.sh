#!/bin/bash

# Set /config/etc

if [[ ! -d "/config/etc" && -d "/etc/netdata" ]]; then 
	mv /etc/netdata /config/etc/
fi

if [ ! -h "/etc/netdata" ]; then
	rm -rf /etc/netdata
	ln -s /config/etc /etc/netdata
fi

# Set /config/log

if [[ ! -d "/config/log" && -d "/var/log/netdata" ]]; then
	mv /var/log/netdata /config/log
fi

if [ ! -h "/var/log/netdata" ]; then
	rm -rf /var/log/netdata
	ln -s /config/log /var/log/netdata
fi

# Set /config/lib

if [[ ! -d "/config/lib" && -d "/var/lib/netdata" ]]; then
    mv /var/lib/netdata /config/lib
fi

if [ ! -h "/var/lib/netdata" ]; then
    rm -rf /var/lib/netdata
    ln -s /config/lib /var/lib/netdata
fi

# Set /config/cache

if [[ ! -d "/config/cache" && -d "/var/cache/netdata" ]]; then
	mv /var/cache/netdata /config/cache
fi

if [ ! -h "/var/cache/netdata" ]; then
	rm -rf /var/cache/netdata
	ln -s /config/cache /var/cache/netdata
fi

# fix permissions due to netdata running as root
chown -R root:root /usr/share/netdata/web

ls -la /usr/share/netdata/web > /root/netdata.log

# Launch netdata

/usr/sbin/netdata -D -u root -s /host
