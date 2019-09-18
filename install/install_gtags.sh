#!/bin/bash

set -e

version=6.6
wget http://tamacom.com/global/global-${version}.tar.gz
tar zxf global-${version}.tar.gz

cd global-${version}

./configure
make -j 40
sudo make install

cd ../
