FROM debian:latest
MAINTAINER Joe Ortiz

ENV PCRE      pcre-8.36
ENV ZLIB      zlib-1.2.8
ENV HTTPD     httpd-2.4.10
ENV APRUTIL   apr-util-1.5.4
ENV APR       apr-1.5.1

# install deps
RUN apt-get update && \
    apt-get install -y wget gcc libcap-dev bzip2 make g++ python autoconf && \
# build pcre
    cd / && wget http://files.directadmin.com/services/custombuild/$PCRE.tar.gz && \
    tar xf $PCRE.tar.gz && \
    cd $PCRE && \
    ./configure --enable-utf8 --enable-unicode-properties --prefix=/opt && \
    make && \
    make install && \
    rm -fr /$PCRE.tar.gz /$PCRE && \
# build zlib
    cd / && wget http://files.directadmin.com/services/custombuild/$ZLIB.tar.gz && \
    tar xf $ZLIB.tar.gz && \
    cd $ZLIB && \
    ./configure --prefix=/opt && \
    make && \
    make install && \
    rm -fr /$ZLIB.tar.gz /$ZLIB && \
# build apache
    cd / && wget http://files.directadmin.com/services/custombuild/$HTTPD.tar.gz && \
    wget http://files.directadmin.com/services/custombuild/$APR.tar.gz && \
    wget http://files.directadmin.com/services/custombuild/$APRUTIL.tar.gz && \
    tar xf $HTTPD.tar.gz && \
    tar xf $APR.tar.gz --no-same-owner -C $HTTPD/srclib && \
    mv -f $HTTPD/srclib/$APR $HTTPD/srclib/apr && \
    tar xf $APRUTIL.tar.gz --no-same-owner -C $HTTPD/srclib && \
    mv -f $HTTPD/srclib/$APRUTIL $HTTPD/srclib/apr-util && \
    cd $HTTPD && \
    ./configure \
              --prefix=/opt/apache \
              --exec-prefix=/opt/apache \
              --bindir=/opt/apache/bin \
              --sbindir=/opt/apache/sbin \
              --sysconfdir=/opt/apache/conf \
              --enable-so \
              --enable-deflate \
              --enable-unique-id \
              --enable-cgi \
              --disable-cgid \
              --enable-mods-static=most \
              --enable-mpms-shared=all \
              --with-included-apr \
              --with-pcre=/opt \
              --with-z=/opt \
              --includedir=/opt/include/apache \
              --libexecdir=/opt/lib/apache \
              --datadir=/opt/apache/www \
              --localstatedir=/opt \
              --enable-rewrite \
              --enable-expires \
              --enable-reqtimeout \
              --enable-headers && \
    make && \
    make install && \
    rm -fr /$HTTPD.tar.gz /$HTTPD /$APR.tar.gz /$APRUTIL.tar.gz && \
    apt-get autoremove -y wget gcc libcap-dev bzip2 make g++ python autoconf && \
    apt-get clean
