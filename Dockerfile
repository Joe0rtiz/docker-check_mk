# install nagios 4.0.8 / nagios plugins 2.0.3 / pnp4nagios 0.6.24 / check_mk 1.2.5i5p4 on centos 7
FROM centos:centos7

# info
MAINTAINER Joe Ortiz version: 0.2

ENV NAGIOS_VERSION 4.0.8
ENV NAGIOS_PLUGINS_VERSION 2.0.3
ENV PNP4NAGIOS_VERSION  0.6.24
ENV CHECKMK_VERSION 1.2.5i5p4

# update container
RUN yum -y update && \
    yum -y install epel-release && \
    yum -y install gd \
                   gd-devel \
                   wget \
                   httpd \
                   php \
                   gcc \
                   make \
                   perl \
                   tar \
                   supervisor \
                   rrdtool \
                   perl-Time-HiRes \
                   rrdtool-perl \
                   php-gd \
                   gcc-c++ \
                   git \
                   httpd-devel \
                   python-devel \
                   sudo \
                   traceroute

# users and groups
RUN adduser nagios && \
    groupadd nagcmd && \
    usermod -a -G nagcmd nagios && \
    usermod -a -G nagcmd apache

# install nagios
RUN wget -nv -O /nagios-$NAGIOS_VERSION.tar.gz http://downloads.sourceforge.net/project/nagios/nagios-4.x/nagios-4.0.8/nagios-$NAGIOS_VERSION.tar.gz && \
    tar xf nagios-$NAGIOS_VERSION.tar.gz && \
    cd nagios-$NAGIOS_VERSION && \
    ./configure --with-command-group=nagcmd && \
    make all && \
    make install && \
    make install-init && \
    make install-config && \
    make install-commandmode && \
    make install-webconf && \
    rm -fr /nagios-$NAGIOS_VERSION.tar.gz /nagios-$NAGIOS_VERSION

# user/password = nagiosadmin/nagiosadmin
RUN echo "nagiosadmin:M.t9dyxR3OZ3E" > /usr/local/nagios/etc/htpasswd.users
RUN chown nagios:nagios /usr/local/nagios/etc/htpasswd.users

# install plugins
RUN wget -nv -O /nagios-plugins-$NAGIOS_PLUGINS_VERSION.tar.gz http://nagios-plugins.org/download/nagios-plugins-$NAGIOS_PLUGINS_VERSION.tar.gz && \
    tar xf nagios-plugins-$NAGIOS_PLUGINS_VERSION.tar.gz && \
    cd nagios-plugins-$NAGIOS_PLUGINS_VERSION && \
    ./configure --with-nagios-user=nagios --with-nagios-group=nagcmd \
    make && \
    make install && \
    rm -fr /nagios-plugins-$NAGIOS_PLUGINS_VERSION.tar.gz nagios-plugins-$NAGIOS_PLUGINS_VERSION

# install pnp4nagios
RUN wget -nv -O /pnp4nagios-$PNP4NAGIOS_VERSION.tar.gz http://downloads.sourceforge.net/project/pnp4nagios/PNP-0.6/pnp4nagios-$PNP4NAGIOS_VERSION.tar.gz && \
    tar xf pnp4nagios-$PNP4NAGIOS_VERSION.tar.gz && \
    cd pnp4nagios-$PNP4NAGIOS_VERSION && \
    ./configure --with-nagios-user=nagios --with-nagios-group=nagcmd --with-perfdata-dir=/data/perfdata --with-perfdata-spool-dir=/data/perfspool && \
    make all && \
    make fullinstall && \
    rm -fr /pnp4nagios-$PNP4NAGIOS_VERSION.tar.gz pnp4nagios-$PNP4NAGIOS_VERSION /usr/local/pnp4nagios/share/install.php /usr/local/pnp4nagios/etc/config_local.php

ADD pnp4nagios/config.php /usr/local/pnp4nagios/etc/config.php
ADD pnp4nagios/process_perfdata.cfg /usr/local/pnp4nagios/etc/process_perfdata.cfg

# install check_mk
ADD check_mk/check_mk_setup.conf /root/.check_mk_setup.conf
ADD check_mk/check_mk_setup.conf /.check_mk_setup.conf
RUN wget -nv -O /check_mk-$CHECKMK_VERSION.tar.gz http://mathias-kettner.com/download/check_mk-$CHECKMK_VERSION.tar.gz && \
    tar xf check_mk-$CHECKMK_VERSION.tar.gz && \
    cd check_mk-$CHECKMK_VERSION && \
    ./setup.sh --yes && \
    rm -fr /check_mk-$CHECKMK_VERSION.tar.gz check_mk-$CHECKMK_VERSION /.check_mk_setup.conf /root/.check_mk_setup.conf

# install mod_python
RUN git clone https://github.com/grisha/mod_python.git mod_python && \
    cd mod_python && \
    ./configure && \
    make && \
    make install && \
    rm -fr /mod_python && \
    echo "LoadModule python_module modules/mod_python.so" > /etc/httpd/conf.modules.d/00-python.conf

# some extra stuff
RUN touch /var/www/html/index.html
RUN mkdir -p /data/perfdata /data/rrdcached.journal /data/mkeventd /data/check_mk /data/check_mk_conf /data/nagios.perfdump /data/nagios.perfdump /var/run/rrdcached
ADD nagios/nagios.cfg /usr/local/nagios/etc/nagios.cfg
ADD nagios/bulknpcd.cfg /usr/local/nagios/etc/objects/bulknpcd.cfg
RUN chown nagios.nagcmd -R /usr/local/nagios/var/rw /data /usr/local/nagios/etc/nagios.cfg /usr/local/nagios/etc/objects/bulknpcd.cfg /var/run/rrdcached /usr/local/pnp4nagios/etc/config.php
RUN chmod g+rwx /usr/local/nagios/var/rw /data/check_mk_conf/mkeventd.d/wato
RUN chmod g+s /usr/local/nagios/var/rw /data/check_mk_conf/mkeventd.d/wato

# create initial config
RUN /usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg

# remove unwanted packages now
RUN yum -y remove gcc gcc-c++ git httpd-devel python-devel && \
    yum clean all

# port 80
EXPOSE 80

# supervisor configuration
ADD supervisord.conf /etc/supervisord.conf
ADD ./bin /app/bin

# Recompile Check_MK Config and then start up nagios, apache, npcd, mkeventd
ENTRYPOINT [ "/bin/bash" ]
CMD [ "/app/bin/start" ]
