#!/bin/bash

set -e

VERSION=7.62.0

wget https://curl.haxx.se/download/curl-${VERSION}.tar.gz
tar zxf curl-${VERSION}.tar.gz

cd curl-${VERSION}

./configure --with-ssl=
make -j 4
sudo make install

cd ..

