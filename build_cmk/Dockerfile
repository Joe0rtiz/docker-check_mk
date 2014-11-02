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
RUN usermod -a -G nagcmd www-data

# install nagios
RUN apt-get install -y build-essential wget && \
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
    apt-get autoremove -y build-essential wget && \
    apt-get autoremove -y build-essential && apt-get autoclean

# user/password = nagiosadmin/nagiosadmin
RUN echo "nagiosadmin:M.t9dyxR3OZ3E" > /usr/local/nagios/etc/htpasswd.users
RUN chown nagios:nagios /usr/local/nagios/etc/htpasswd.users

# install plugins
RUN apt-get install -y build-essential wget && \
    wget -nv -O /nagios-plugins-$NAGIOS_PLUGINS_VERSION.tar.gz http://nagios-plugins.org/download/nagios-plugins-$NAGIOS_PLUGINS_VERSION.tar.gz && \
    tar xf nagios-plugins-$NAGIOS_PLUGINS_VERSION.tar.gz && \
    cd nagios-plugins-$NAGIOS_PLUGINS_VERSION && \
    ./configure --with-nagios-user=nagios --with-nagios-group=nagcmd && \
    make && \
    make install && \
    rm -fr /nagios-plugins-$NAGIOS_PLUGINS_VERSION.tar.gz nagios-plugins-$NAGIOS_PLUGINS_VERSION && \
    apt-get autoremove -y build-essential wget && \
    apt-get autoremove -y build-essential && apt-get autoclean
