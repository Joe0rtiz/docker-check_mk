FROM debian:latest
MAINTAINER Joe Ortiz

ENV LIBTOOL    libtool-2.4
ENV PCRE      pcre-8.36
ENV ZLIB      zlib-1.2.8
ENV HTTPD     httpd-2.4.10
ENV CURL      curl-7.38.0
ENV LIBXML    libxml2-2.9.2
ENV LIBPNG    libpng-1.6.12
ENV PHP       php-5.6.2
ENV FREETYPE  freetype-2.5.3
ENV LIBICONV  libiconv-1.14
ENV LIBMCRYPT libmcrypt-2.5.8
ENV LIBXSLT   libxslt-1.1.28
ENV APRUTIL   apr-util-1.5.4
ENV APR       apr-1.5.1

# install deps
RUN apt-get update && \
    apt-get install -y wget gcc libcap-dev bzip2 make g++ python autoconf && \
# build libtool
    wget http://files.directadmin.com/services/custombuild/$LIBTOOL.tar.gz && \
    tar xf $LIBTOOL.tar.gz && \
    cd $LIBTOOL && \
    ./configure --prefix=/opt/libtool && \
    make && \
    make install && \
    rm -fr /$LIBTOOL.tar.gz /$LIBTOOL && \
# build pcre
    cd / && wget http://files.directadmin.com/services/custombuild/$PCRE.tar.gz && \
    tar xf $PCRE.tar.gz && \
    cd $PCRE && \
    ./configure --enable-static --enable-utf8 --enable-unicode-properties --prefix=/opt/pcre && \
    make && \
    make install && \
    rm -fr /$PCRE.tar.gz /$PCRE && \
# build zlib
    cd / && wget http://files.directadmin.com/services/custombuild/$ZLIB.tar.gz && \
    tar xf $ZLIB.tar.gz && \
    cd $ZLIB && \
    ./configure --prefix=/opt/zlib && \
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
              --with-pcre=/opt/pcre \
              --with-z=/opt/zlib \
              --includedir=/opt/apache/include \
              --libexecdir=/opt/apache/lib \
              --datadir=/opt/apache/www \
              --localstatedir=/opt/apache \
              --enable-rewrite \
              --enable-expires \
              --enable-reqtimeout \
              --enable-headers && \
    make && \
    make install && \
    rm -fr /$HTTPD.tar.gz /$HTTPD /$APR.tar.gz /$APRUTIL.tar.gz && \
# build curl
    cd / && wget http://files.directadmin.com/services/custombuild/$CURL.tar.gz && \
    tar xf $CURL.tar.gz && \
    cd $CURL && \
    ./configure --enable-static --prefix=/opt/curl && \
    make && \
    make install && \
    rm -fr /$CURL.tar.gz /$CURL && \
# build libxml2
    cd / && wget http://files.directadmin.com/services/custombuild/$LIBXML.tar.gz && \
    tar xf $LIBXML.tar.gz && \
    cd $LIBXML && \
    ./configure --enable-static --prefix=/opt/libxml --without-python --with-zlib=/opt/zlib && \
    make && \
    make install && \
    rm -fr /$LIBXML.tar.gz /$LIBXML && \
# build jpeg
    cd / && wget http://files.directadmin.com/services/custombuild/jpegsrc.v9.tar.gz && \
    tar xf jpegsrc.v9.tar.gz && \
    cd jpeg-9 && \
    ./configure --enable-static --prefix=/opt/libjpeg && \
    make && \
    make install && \
    rm -fr /jpegsrc.v9.tar.gz /jpeg-9 && \
# build png
    cd / && wget http://files.directadmin.com/services/custombuild/$LIBPNG.tar.gz && \
    tar xf $LIBPNG.tar.gz && \
    cd $LIBPNG && \
    export LDFLAGS="-L/opt/zlib/lib" && \
    export CPPFLAGS="-I/opt/zlib/include" && \
    ./configure --enable-static --prefix=/opt/libpng && \
    make && \
    make install && \
    rm -fr /$LIBPNG.tar.gz /$LIBPNG && \
# build freetype
    cd / && wget http://files.directadmin.com/services/custombuild/$FREETYPE.tar.gz && \
    tar xf $FREETYPE.tar.gz && \
    cd $FREETYPE && \
    ./configure --enable-static --prefix=/opt/freetype && \
    make && \
    make install && \
    rm -fr /$FREETYPE.tar.gz /$FREETYPE && \
# build iconv
    cd / && wget http://files.directadmin.com/services/custombuild/$LIBICONV.tar.gz && \
    tar xf $LIBICONV.tar.gz && \
    cd $LIBICONV && \
    ./configure --enable-static --prefix=/opt/iconv --enable-extra-encodings && \
    make && \
    make install && \
    rm -fr /$LIBICONV.tar.gz /$LIBICONV && \
# build libmcrypt
    cd / && wget http://files.directadmin.com/services/custombuild/$LIBMCRYPT.tar.gz && \
    tar xf $LIBMCRYPT.tar.gz && \
    cd $LIBMCRYPT && \
    ./configure --enable-static --prefix=/opt/mcrypt --enable-ltdl-install && \
    make && \
    make install && \
    rm -fr /$LIBMCRYPT.tar.gz /$LIBMCRYPT && \
# build libxslt
    cd / && wget http://files.directadmin.com/services/custombuild/$LIBXSLT.tar.gz && \
    tar xf $LIBXSLT.tar.gz && \
    cd $LIBXSLT && \
    ./configure --enable-static --prefix=/opt/libxslt --with-libxml-prefix=/opt/libxml --with-libxml-include-prefix=/opt/libxml/include --with-libxml-libs-prefix=/opt/libxml/lib && \
    make && \
    make install && \
    rm -fr /$LIBXSLT.tar.gz /$LIBXSLT && \
# build php
    cd / && wget http://files.directadmin.com/services/custombuild/$PHP.tar.gz && \
    tar xf $PHP.tar.gz && \
    cd $PHP && \
    ./configure \
        --enable-static=yes \
        --enable-shared=no \
        --prefix=/opt/php \
        --with-apache=/opt/apache \
        --with-config-file-scan-dir=/opt/php/etc/php.conf.d \
        --with-curl=/opt/curl \
        --with-gd \
        --enable-gd-native-ttf \
        --with-gettext \
        --with-jpeg-dir=/opt/libjpeg \
        --with-freetype-dir=/opt/freetype \
        --enable-libxml \
        --enable-xml \
        --with-libxml-dir=/opt/libxml \
        --with-mcrypt=/opt/mcrypt \
        --with-mhash \
        --with-pcre-regex=/opt/pcre \
        --with-pear \
        --with-png-dir=/opt/libpng \
        --enable-dom \
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
        --enable-mbstring \
        --disable-cgi \
        --disable-all && \
    make && \
    make install && \
    rm -fr /$PHP.tar.gz /$PHP && \
    apt-get remove -y wget gcc libcap-dev bzip2 make g++ python autoconf
