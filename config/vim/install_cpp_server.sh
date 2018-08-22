#!/bin/bash

if command -v llvm > /dev/null 2>&1; then
	echo 'llvm is installed.'
else
	echo 'llvm is requried, please install it first.'
fi

