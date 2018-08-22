#!/bin/bash

set -e

pushd `pwd`

mkdir -p ~/.vim/plugged
cd ~/.vim/plugged/

if [ -d YouCompleteMe ]; then
	echo 'YouCompleteMe exists'
else
	echo 'download YouCompleteMe first...'
	git clone --depth=1 --recursive https://github.com/Valloric/YouCompleteMe.git
fi

cd YouCompleteMe
git submodule update --init --recursive

mkdir -p ~/.code/YouCompleteMe

# cargo need for rust-completer
# java-completer
python install.py --clang-completer --go-completer --build-dir=~/.code/YouCompleteMe --quiet

# cd ~/.code/YouCompleteMe
#
# cmake -G "Unix Makefiles" . ~/.vim/plugged/YouCompleteMe/third_party/ycmd/cpp
#
# cmake --build . --target ycm_core --config Release -- -j 8
#

popd
