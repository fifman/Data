#!/bin/sh

git config --global user.name "fifman"
git config --global user.email "1264380449@qq.com"

# 修正stow不能正确在babun上使用的问题
cd /usr/lib/perl5/vendor_perl/5.14  || exit
ln -s ../5.22/Stow && ln -s ../5.22/Stow.pm

# install vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java8-installer
sudo apt-get install oracle-java8-set-default

# install rename of perl
git clone https://github.com/subogero/rename.git
cd rename || exit
sudo make install
cd ..
rm -rf rename

# install mongodb
sudo apt-get install mongodb
#sudo mkdir -p /var/mongodb
#sudo chown fifman /var/mongodb

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
sudo apt-get update
sudo apt-get install -y mongodb-org
#sudo service mongod start
# enable service to start on boot
sudo systemctl enable mongod.service

# remote desktop enable
sudo apt-get install tightvncserver
sudo apt-get install xrdp
sudo apt-get install xfce4
echo xfce4-session >~/.xsession

sudo vim /etc/xrdp/startwm.sh
# need to input the following content:
##!/bin/sh

#if [ -r /etc/default/locale ]; then
  #. /etc/default/locale
  #export LANG LANGUAGE
#fi

#startxfce4
sudo service xrdp restart
