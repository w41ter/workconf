#!/bin/bash

set -e

source git_tags.sh

pushd `pwd`

mkdir -p ~/.code
cd ~/.code

if [ -d neovim ]; then
	echo 'neovim exists'
else
	echo 'neovim not exist, try download it...'
	git clone --depth=1 https://github.com/neovim/neovim.git
fi

cd neovim

echo 'try update neovim'

#git pull --rebase
update_tags

echo 'try compile and install neovim'

make -j 8 CMAKE_EXTRA_FLAGS="-DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=~/.bin/neovim"
make install

mkdir -p ~/.bin/local/
rm -rf ~/.bin/local/nvim
ln -s ~/.bin/neovim/bin/nvim ~/.bin/local/nvim

pip install neovim --user

popd
