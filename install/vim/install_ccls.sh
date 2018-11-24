#!/bin/bash

set -x

pushd `pwd`

mkdir -p ~/.code
cd ~/.code/

git clone https://github.com/MaskRay/ccls --depth=1
cd ccls
git submodule update --init

case $1 in
	debian)
		sudo apt -y install zlib1g-dev ncurses-dev
		;;
	*)
		;;
esac

cmake -H. -BRelease -DCMAKE_PREFIX_PATH=~/.bin/ 
# -DSYSTEM_CLANG=on

ncpu=`nproc`  #`sysctl -n hw.ncpu`
cmake --build Release -- -j${ncpu}

mkdir -p ~/.bin/local
ln -s ~/.code/ccls/Release/ccls ~/.bin/local/ccls

popd 
