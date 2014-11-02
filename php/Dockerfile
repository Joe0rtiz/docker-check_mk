FROM shiekron/apache
MAINTAINER Joe Ortiz

ENV CURL      curl-7.38.0
ENV LIBXML    libxml2-2.9.2
ENV LIBPNG    libpng-1.6.12
ENV PHP       php-5.6.2
ENV FREETYPE  freetype-2.5.3
ENV LIBICONV  libiconv-1.14
ENV LIBMCRYPT libmcrypt-2.5.8
ENV LIBXSLT   libxslt-1.1.28

# install deps
RUN apt-get update && \
    apt-get install -y wget gcc libcap-dev bzip2 make g++ autoconf && \
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
    ./configure --enable-static --prefix=/opt/libxml --without-python --with-zlib=/opt && \
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
    export LDFLAGS="-L/opt/lib" && \
    export CPPFLAGS="-I/opt/include" && \
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
        --with-apache=/opt \
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
        --with-zlib-dir=/opt \
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
    apt-get remove -y wget gcc libcap-dev bzip2 make g++ autoconf
