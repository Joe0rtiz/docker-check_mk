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
