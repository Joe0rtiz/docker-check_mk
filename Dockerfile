# install nagios 4.0.8 / pnp4nagios 0.6.24 / check_mk 1.2.5i5p4 on centos 7
FROM centos:centos7

# info
MAINTAINER Joe Ortiz version: 0.1

# update container
RUN yum -y update
RUN yum -y install epel-release
RUN yum -y install gd gd-devel wget httpd php gcc make perl tar sendmail supervisor rrdtool perl-Time-HiRes rrdtool-perl php-gd gcc-c++

# users and groups
RUN adduser nagios
RUN groupadd nagcmd
RUN usermod -a -G nagcmd nagios
RUN usermod -a -G nagios apache

# get archives
ADD http://prdownloads.sourceforge.net/sourceforge/nagios/nagios-4.0.8.tar.gz nagios-4.0.8.tar.gz
ADD http://nagios-plugins.org/download/nagios-plugins-2.0.3.tar.gz nagios-plugins-2.0.3.tar.gz
ADD http://downloads.sourceforge.net/project/pnp4nagios/PNP-0.6/pnp4nagios-0.6.24.tar.gz pnp4nagios-0.6.24.tar.gz
ADD http://mathias-kettner.com/download/check_mk-1.2.5i5p4.tar.gz check_mk-1.2.5i5p4.tar.gz

# install nagios
RUN tar xf nagios-4.0.8.tar.gz
RUN cd nagios-4.0.8 && ./configure --with-command-group=nagcmd
RUN cd nagios-4.0.8 && make all && make install && make install-init
RUN cd nagios-4.0.8 && make install-config && make install-commandmode && make install-webconf

# user/password = nagiosadmin/nagiosadmin
RUN echo "nagiosadmin:M.t9dyxR3OZ3E" > /usr/local/nagios/etc/htpasswd.users
RUN chown nagios:nagios /usr/local/nagios/etc/htpasswd.users

# install plugins
RUN tar xf nagios-plugins-2.0.3.tar.gz
RUN cd nagios-plugins-2.0.3 && ./configure --with-nagios-user=nagios --with-nagios-group=nagios
RUN cd nagios-plugins-2.0.3 && make && make install

# create initial config
RUN /usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg

# install pnp4nagios
RUN tar xf check_mk-1.2.5i5p4.tar.gz
RUN cd check_mk-1.2.5i5p4 && ./configure
RUN cd check_mk-1.2.5i5p4 && make all && make fullinstall

# install check_mk
ADD check_mk_setup.conf /root/.check_mk_setup.conf
RUN tar xf check_mk-1.2.5i5p4.tar.gz
RUN cd check_mk-1.2.5i5p4 && ./setup.sh --yes

# some extra stuff
RUN touch /var/www/html/index.html
RUN mkdir -p /data/perfdata /data/rrdcached.journal /data/mkeventd /data/check_mk /data/check_mk_conf /data/nagios.perfdump
RUN chown nagios.nagcmd /usr/local/nagios/var/rw /data/perfdata /data/rrdcached.journal /data/mkeventd /data/check_mk /data/check_mk_conf /data/nagios.perfdump
RUN chmod g+rwx /usr/local/nagios/var/rw
RUN chmod g+s /usr/local/nagios/var/rw
ADD nagios.cfg /usr/local/nagios/etc/nagios.cfg
ADD bulknpcd.cfg /usr/local/nagios/etc/bulknpcd.cfg

# init bug fix
# RUN sed -i '/$NagiosBin -d $NagiosCfgFile/a (sleep 10; chmod 666 \/usr\/local\/nagios\/var\/rw\/nagios\.cmd) &' /etc/init.d/nagios

# remove gcc
RUN yum -y remove gcc gcc-c++

# clean up
RUN rm -fr nagios-4.0.8 nagios-4.0.8.tar.gz nagios-plugins-2.0.3 nagios-plugins-2.0.3.tar.gz pnp4nagios-0.6.24.tar.gz pnp4nagios-0.6.24 check_mk-1.2.5i5p4.tar.gz check_mk-1.2.5i5p4

# port 80
EXPOSE 25 80

# supervisor configuration
ADD supervisord.conf /etc/supervisord.conf

# start up nagios, sendmail, apache, npcd
CMD ["/usr/bin/supervisord"]
