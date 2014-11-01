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
    rm -fr /libtool-2.4.tar.gz /libtool-2.4

# build pcre
RUN wget http://files.directadmin.com/services/custombuild/pcre-8.36.tar.gz && \
    tar xf pcre-8.36.tar.gz && \
    cd pcre-8.36 && \
    ./configure --enable-utf8 --enable-unicode-properties --disable-shared --prefix=/opt/pcre && \
    make && \
    make install && \
    rm -fr /pcre-8.36.tar.gz /pcre-8.36

# build zlib
RUN wget http://files.directadmin.com/services/custombuild/zlib-1.2.8.tar.gz && \
    tar xf zlib-1.2.8.tar.gz && \
    cd zlib-1.2.8 && \
    ./configure --prefix=/opt/zlib && \
    make && \
    make install && \
    rm -fr /zlib-1.2.8.tar.gz /zlib-1.2.8

# build apache
RUN wget http://files.directadmin.com/services/custombuild/httpd-2.4.10.tar.gz && \
    wget http://files.directadmin.com/services/custombuild/apr-1.5.1.tar.gz && \
    wget http://files.directadmin.com/services/custombuild/apr-util-1.5.4.tar.gz && \
    tar xf httpd-2.4.10.tar.gz && \
    tar xf apr-1.5.1.tar.gz --no-same-owner -C httpd-2.4.10/srclib && \
    mv -f httpd-2.4.10/srclib/apr-1.5.1 httpd-2.4.10/srclib/apr && \
    tar xf apr-util-1.5.4.tar.gz --no-same-owner -C httpd-2.4.10/srclib && \
    mv -f httpd-2.4.10/srclib/apr-util-1.5.4 httpd-2.4.10/srclib/apr-util && \
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
    rm -fr /httpd-2.4.10.tar.gz /httpd-2.4.10 /apr-1.5.1.tar.gz /apr-util-1.5.4.tar.gz

# build curl
RUN wget http://files.directadmin.com/services/custombuild/curl-7.38.0.tar.gz && \
    tar xf curl-7.38.0.tar.gz && \
    cd curl-7.38.0 && \
    ./configure --prefix=/opt/curl && \
    make && \
    make install && \
    rm -fr /curl-7.38.0.tar.gz /curl-7.38.0

# build libxml2
RUN wget http://files.directadmin.com/services/custombuild/libxml2-2.9.2.tar.gz && \
    tar xf libxml2-2.9.2.tar.gz && \
    cd libxml2-2.9.2 && \
    ./configure --prefix=/opt/libxml --without-python --with-zlib=/opt/zlib && \
    make && \
    make install && \
    rm -fr /libxml2-2.9.2.tar.gz /libxml2-2.9.2

# build jpeg
RUN wget http://files.directadmin.com/services/custombuild/jpegsrc.v9.tar.gz && \
    tar xf jpegsrc.v9.tar.gz && \
    cd jpeg-9 && \
    ./configure --prefix=/opt/libjpeg && \
    make && \
    make install-lib && \
    rm -fr /jpegsrc.v9.tar.gz /jpeg-9

# build png
RUN wget http://files.directadmin.com/services/custombuild/libpng-1.6.12.tar.gz && \
    tar xf libpng-1.6.12.tar.gz && \
    cd libpng-1.6.12 && \
    export LDFLAGS="-L/opt/zlib/lib" && \
    export CPPFLAGS="-I/opt/zlib/include" && \
    ./configure --prefix=/opt/libpng && \
    make && \
    make install && \
    rm -fr /libpng-1.6.12.tar.gz /libpng-1.6.12

# build freetype
RUN wget http://files.directadmin.com/services/custombuild/freetype-2.5.3.tar.gz && \
    tar xf freetype-2.5.3.tar.gz && \
    cd freetype-2.5.3 && \
    ./configure --prefix=/opt/freetype && \
    make && \
    make install && \
    rm -fr /freetype-2.5.3.tar.gz /freetype-2.5.3

# build iconv
RUN wget http://files.directadmin.com/services/custombuild/libiconv-1.14.tar.gz && \
    tar xf libiconv-1.14.tar.gz && \
    cd libiconv-1.14 && \
    ./configure --prefix=/opt/iconv --enable-extra-encodings && \
    make && \
    make install && \
    rm -fr /libiconv-1.14.tar.gz /libiconv-1.14

# build libmcrypt
RUN wget http://files.directadmin.com/services/custombuild/libmcrypt-2.5.8.tar.gz && \
    tar xf libmcrypt-2.5.8.tar.gz && \
    cd libmcrypt-2.5.8 && \
    ./configure --prefix=/opt/mcrypt --enable-ltdl-install && \
    make && \
    make install && \
    rm -fr /libmcrypt-2.5.8.tar.gz /libmcrypt-2.5.8

# build libxslt
RUN wget http://files.directadmin.com/services/custombuild/libxslt-1.1.28.tar.gz && \
    tar xf libxslt-1.1.28.tar.gz && \
    cd libxslt-1.1.28 && \
    ./configure --prefix=/opt/libxslt --with-libxml-prefix=/opt/libxml --with-libxml-include-prefix=/opt/libxml/include --with-libxml-libs-prefix=/opt/libxml/lib && \
    make && \
    make install && \
    rm -fr /libxslt-1.1.28.tar.gz /libxslt-1.1.28

# build php
RUN wget http://files.directadmin.com/services/custombuild/php-5.6.2.tar.gz && \
    tar xf php-5.6.2.tar.gz && \
    cd php-5.6.2 && \
    ./configure \
        --prefix=/opt/php \
        --with-apxs2=/opt/bin/apxs \
        --with-config-file-scan-dir=/opt/php/etc/php.conf.d \
        --with-curl=/opt/curl \
        --with-gd \
        --enable-gd-native-ttf \
        --with-gettext \
        --with-jpeg-dir=/opt/libjpeg \
        --with-freetype-dir=/opt/freetype \
        --with-libxml-dir=/opt/libxml \
        --with-mcrypt=/opt/mcrypt \
        --with-mhash \
        --with-pcre-regex=/opt/pcre \
        --with-pear \
        --with-png-dir=/opt/libpng \
        --with-xsl=/opt/libxslt \
        --with-zlib \
        --with-zlib-dir=/opt/zlib \
        --enable-zip \
        --with-iconv=/opt/iconv \
        --enable-bcmath \
        --enable-calendar \
        --enable-ftp \
        --enable-sockets \
        --enable-soap \
        --enable-mbstring && \
    make && \
    make install && \
    rm -fr /php-5.6.2.tar.gz /php-5.6.2
