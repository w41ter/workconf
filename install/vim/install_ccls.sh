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

cmake -H. -BRelease -DCMAKE_PREFIX_PATH=~/.bin/ -DSYSTEM_CLANG=on
cmake --build Release -- -j8
ln -s ~/.code/ccls/Release/ccls ~/.bin/local/ccls

popd 
