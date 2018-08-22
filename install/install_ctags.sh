#!/bin/bash

set -e

pushd `pwd`

mkdir -p ~/.code
cd ~/.code

if [ -d ctags ]; then
	echo 'ctags exitst'
else
	echo 'download ctags first...'
	git clone --depth=1 https://github.com/universal-ctags/ctags.git
fi

cd ctags

echo 'try update ctags...'
git pull --rebase

echo 'try compile ctags...'
# USER_DIR=$(echo $(getent passwd $USER )| cut -d : -f 6)
mkdir -p ~/.bin/ctags
./autogen.sh
./configure --prefix=${HOME}/.bin/ctags/
make -j 8
make install

echo 'try install ctags...'
mkdir -p ~/.bin/local
ln -s ~/.bin/ctags/bin/ctags ~/.bin/local/ctags
ln -s ~/.bin/ctags/bin/readtags ~/.bin/local/readtags

echo 'install ctags success'

