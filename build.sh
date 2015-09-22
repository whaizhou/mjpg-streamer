#!/bin/bash
set -x
set -e

#chmod 644 /etc/resolv.conf

#echo '--------- OLD -----------'
#cat /etc/apt/sources.list
#echo 'deb ftp://carroll.aset.psu.edu/pub/linux/distributions/debian/ wheezy main contrib non-free' >>  /etc/apt/sources.list

#sed -i 's/ftp.us.debian.org/128.61.240.89/g' /etc/apt/sources.list
#sed -i 's/security.debian.org/128.101.240.212/g' /etc/apt/sources.list
#sed -i 's/carroll.aset.psu.edu/128.118.2.96/g' /etc/apt/sources.list

#echo '--------- NEW -----------'
#cat /etc/apt/sources.list
apt-get update -qq
apt-get install -y \
g++ \
cmake \
build-essential \
imagemagick \
pkg-config \
libv4l-dev \
v4l-utils \
v4l2ucp \
libjpeg62-turbo-dev

mkdir -p tmp/mjpg-streamer_install/usr/local/
mkdir -p tmp/mjpg-streamer_install/usr/local/bin
mkdir -p tmp/mjpg-streamer_install/usr/local/lib

cd mjpg-streamer
patch -p 0< patches/20150920_KernelFixBreaksUVCvideo.patch
make install DESTDIR=../tmp/mjpg-streamer_install/usr/local
