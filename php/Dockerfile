FROM shiekron/php_deps
MAINTAINER Joe Ortiz

ENV PHP       php-5.6.2

# install deps
RUN apt-get update && \
    apt-get install -y wget gcc libcap-dev bzip2 make g++ autoconf && \
# build php
    cd / && wget http://files.directadmin.com/services/custombuild/$PHP.tar.gz && \
    tar xf $PHP.tar.gz && \
    cd $PHP && \
    ./configure \
        --enable-static=yes \
        --enable-shared=no \
        --prefix=/opt/php \
        --with-apache=/opt/include \
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
    apt-get autoremove -y wget gcc libcap-dev bzip2 make g++ autoconf && \
    apt-get clean
