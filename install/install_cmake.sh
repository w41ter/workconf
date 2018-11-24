#!/bin/bash

set -e

VERSION=3.13.0

wget https://github.com/Kitware/CMake/releases/download/v${VERSION}/cmake-${VERSION}.tar.gz
tar zxf cmake-${VERSION}.tar.gz

cd cmake-${VERSION}

./bootstrap --system-curl
make -j 4
sudo make install

cd ..

