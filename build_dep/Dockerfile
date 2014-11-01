FROM ubuntu:14.04
MAINTAINER Joe Ortiz

# install deps
RUN apt-get update && \
    apt-get install -y wget gcc libcap-dev bzip2 make g++ python autoconf

# build libtool
RUN wget http://files.directadmin.com/services/custombuild/libtool-2.4.tar.gz && \
    tar xf libtool-2.4.tar.gz && \
    cd libtool-2.4 && \
    ./configure --prefix=/opt/libtool && \
    make && \
    make install && \
    rm -fr libtool-2.4.tar.gz libtool-2.4

# build pcre
RUN wget http://files.directadmin.com/services/custombuild/pcre-8.36.tar.gz && \
    tar xf pcre-8.36.tar.gz && \
    cd pcre-8.36 && \
    ./configure --enable-utf8 --enable-unicode-properties --disable-shared --prefix=/opt/pcre && \
    make && \
    make install && \
    rm -fr pcre-8.36.tar.gz pcre-8.36

# build zlib
RUN wget http://files.directadmin.com/services/custombuild/zlib-1.2.8.tar.gz && \
    tar xf zlib-1.2.8.tar.gz && \
    cd zlib-1.2.8 && \
    ./configure --prefix=/opt/zlib && \
    make && \
    make install && \
    rm -fr zlib-1.2.8.tar.gz zlib-1.2.8

# build apache
RUN wget http://files.directadmin.com/services/custombuild/httpd-2.4.10.tar.gz && \
    tar xf httpd-2.4.10.tar.gz && \
    cd httpd-2.4.10 && \
    ./configure \
            	--prefix=/opt/httpd \
            	--exec-prefix=/opt/httpd \
            	--bindir=/opt/bin \
            	--sbindir=/opt/sbin \
            	--sysconfdir=/opt/httpd/conf \
            	--enable-so \
            	--enable-deflate \
            	--enable-unique-id \
            	--enable-cgi \
            	--disable-cgid \
            	--enable-mods-static=most \
            	--enable-mpms-shared=all \
            	--with-included-apr \
            	--with-pcre=/opt/pcre \
            	--with-z=/opt/zlib \
            	--includedir=/opt/include/apache \
            	--libexecdir=/opt/lib/apache \
            	--datadir=/var/www \
            	--localstatedir=/var \
            	--enable-rewrite \
            	--enable-expires \
            	--enable-reqtimeout \
            	--enable-headers && \
    make && \
    make install && \
    rm -fr httpd-2.4.10.tar.gz httpd-2.4.10
