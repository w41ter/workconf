#!/bin/bash

set -x

pushd `pwd`

cd ~/.code/

git clone https://github.com/MaskRay/ccls --depth=1
cd ccls
git submodule update --init
cmake -H. -BRelease -DCMAKE_PREFIX_PATH=~/.bin/
cmake --build Release -- -j8
ln -s ~/.code/ccls/Release/ccls ~/.bin/local/ccls

popd 
