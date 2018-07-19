#!/bin/bash

os=$(uname)

if [[ x$os == x"Darwin" ]]; then
    export PATH=/Library/Developer/CommandLineTools/usr/lib:$PATH
fi

loc=~/.cache/vimfiles/repos/github.com/Valloric

if [ ! -d $loc ]; then
    mkdir -p $loc 
fi

cd $loc || exit

if [ ! -d $loc/YouCompleteMe ]; then
    git clone https://github.com/Valloric/YouCompleteMe.git
fi

cd YouCompleteMe || exit 

git submodule update --init --recursive

./install.py --js-completer --java-completer --go-completer
