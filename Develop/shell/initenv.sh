#!/bin/sh

git config --global user.name "fifman"
git config --global user.email "1264380449@qq.com"

# 修正stow不能正确在babun上使用的问题
cd /usr/lib/perl5/vendor_perl/5.14 
ln -s ../5.22/Stow && ln -s ../5.22/Stow.pm

# install vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java8-installer
sudo apt-get install oracle-java8-set-default
