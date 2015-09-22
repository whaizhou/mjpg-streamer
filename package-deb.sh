#!/bin/bash
set -ex
#Install Pre-req
gem install fpm
export DIR=${PWD#}
export PACKAGE="openrov-mjpeg-streamer"
export PACKAGE_VERSION=2.0.1-9~${BUILD_NUMBER}.`git rev-parse --short HEAD`

ARCH=`uname -m`
if [ ${ARCH} = "armv7l" ]
then
  ARCH="armhf"
fi

./build.sh

#package
cd $DIR
fpm -f -m info@openrov.com -s dir -t deb -a $ARCH \
	-n ${PACKAGE} \
	-v ${PACKAGE_VERSION} \
  --after-install=${DIR}/install_lib/openrov-avrdude-afterinstall.sh \
	--description "OpenROV mjpeg-streamer" \
	-C ${DIR}/tmp/mjpg-streamer_install .
