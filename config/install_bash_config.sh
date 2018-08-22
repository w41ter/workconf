#!/bin/bash

mkdir -p ~/.bin/local/

echo 'export TERM=xterm-256color' >> ~/.bash_profile

echo 'LOCAL_BIN_PATH=~/.bin/local/' >> ~/.bash_profile
echo 'PYTHON_BIN_PATH=~/.local/bin' >> ~/.bash_profile
echo 'export PATH=$LOCAL_BIN_PATH:$PYTHON_BIN_PATH:$PATH' >> ~/.bash_profile

cp bash_color.sh ~/.bash_color
cp bash_alias.sh ~/.bash_alias

echo 'source ~/.bash_color' >> ~/.bash_profile
echo 'source ~/.bash_alias' >> ~/.bash_profile

echo 'now you can install ~/.bash_profile to ~/.bashrc'

