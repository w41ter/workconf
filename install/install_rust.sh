#!/bin/bash

# echo install rust complier
curl https://sh.rustup.rs -sSf | sh

source ~/.bash_profile

# install rust language server
rustup update
rustup component add rls-preview rust-analysis rust-src


