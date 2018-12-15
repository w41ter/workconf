#!/bin/bash

set -x

pushd `pwd`

mkdir -p ~/.code
cd ~/.code/

if [ -d ccls ]; then
	echo 'ccls exists'
else
	echo 'ccls not exists, try download ...'
	git clone https://github.com/MaskRay/ccls --depth=1
fi

cd ccls

echo 'try update ccls'
git fetch origin master
git reset --hard origin/master

git submodule update --init

case $1 in
	debian)
		sudo apt -y install zlib1g-dev ncurses-dev
		;;
	*)
		;;
esac

# https://github.com/MaskRay/ccls/wiki/Getting-started#build-the-ccls-language-server
# cmake -H. -BRelease -DCMAKE_PREFIX_PATH=~/.bin/ -DSYSTEM_CLANG=on -DUSE_SHARED_LLVM=on -DLLVM_BUILD_LLVM_DYLIB=on
cmake -H. -BRelease -DSYSTEM_CLANG=on -DCMAKE_PREFIX_PATH=/usr/lib/llvm-7 -DLLVM_ENABLE_RTTI=on
# See if your system clang uses -DLLVM_ENABLE_RTTI=on

ncpu=`nproc`  #`sysctl -n hw.ncpu`
cmake --build Release -- -j${ncpu} VERBOSE=1

mkdir -p ~/.bin/local
rm -rf ~/.bin/local/ccls
ln -s ~/.code/ccls/Release/ccls ~/.bin/local/ccls

popd
