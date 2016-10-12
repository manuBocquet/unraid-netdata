FROM debian:jessie
MAINTAINER manu <manu.bocquet@gmail.com>

ENV APTLIST="netdata" 

# install main packages
RUN apt-get update -q && \
apt-get install curl libterm-ui-perl git make -qy

# install netdata requirement
RUN curl -Ss 'https://raw.githubusercontent.com/firehol/netdata-demo-site/master/install-required-packages.sh' >/tmp/kickstart.sh && bash /tmp/kickstart.sh --non-interactive  netdata

RUN (cd /tmp && \
	git clone https://github.com/firehol/netdata.git --depth=1 && \
	cd netdata && \
	./netdata-installer.sh )

# cleanup
RUN apt-get clean -y && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir /config
ADD ./init.sh /etc/my_init.sh
RUN chmod 700 /etc/my_init.sh

CMD [ "/etc/my_init.sh" ]

# ports and volumes
EXPOSE 19999
VOLUME [ "/config" ]

