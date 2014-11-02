# install nagios 4.0.8 / nagios plugins 2.0.3 / pnp4nagios 0.6.24 / check_mk 1.2.5i5p4 on Debian
FROM debian:latest

# info
MAINTAINER Joe Ortiz version: 0.2

ENV NAGIOS_VERSION 4.0.8
ENV NAGIOS_PLUGINS_VERSION 2.0.3
ENV PNP4NAGIOS_VERSION  0.6.24
ENV CHECKMK_VERSION 1.2.5i5p4

# update container
RUN apt-get update && \
    apt-get install -y apache2 \
                       libapache2-mod-php5 \
                       libgd2-xpm-dev \
                       traceroute \
                       sudo && \
    apt-get autoclean

# users and groups
RUN adduser nagios
RUN groupadd nagcmd
RUN usermod -a -G nagcmd nagios
RUN usermod -a -G nagcmd apache

# install nagios
RUN agt-get install build-essential && \
    wget -nv -O /nagios-$NAGIOS_VERSION.tar.gz http://downloads.sourceforge.net/project/nagios/nagios-4.x/nagios-4.0.8/nagios-$NAGIOS_VERSION.tar.gz && \
    tar xf nagios-$NAGIOS_VERSION.tar.gz && \
    cd nagios-$NAGIOS_VERSION && \
    ./configure --with-command-group=nagcmd && \
    make all && \
    make install && \
    make install-init && \
    make install-config && \
    make install-commandmode && \
    make install-webconf && \
    rm -fr /nagios-$NAGIOS_VERSION.tar.gz /nagios-$NAGIOS_VERSION && \
    apt-get autoremove -y build-essential && \
    apt-get autoclean
