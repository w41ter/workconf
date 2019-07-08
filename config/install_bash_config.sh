#!/bin/bash

mkdir -p ~/.bin/local/

curl https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.ansi-dark --output ~/.dircolors

echo 'export TERM=xterm-256color' >> ~/.bash_profile

echo 'LOCAL_BIN_PATH=~/.bin/local/' >> ~/.bash_profile
echo 'PYTHON_BIN_PATH=~/.local/bin' >> ~/.bash_profile
echo 'export PATH=$LOCAL_BIN_PATH:$PYTHON_BIN_PATH:$PATH' >> ~/.bash_profile

if [ -f "~/.bash_color" ]; then
	echo "~/.bash_color exists, skip..."
else
	cp bash_color.sh ~/.bash_color
fi

if [ -f "~/.bash_alias" ]; then
	echo "~/.bash_alias exists, skip..."
else
	cp bash_alias.sh ~/.bash_alias
fi

echo 'source ~/.bash_color' >> ~/.bash_profile
echo 'source ~/.bash_alias' >> ~/.bash_profile

echo 'now you can install ~/.bash_profile to ~/.bashrc'

