Set-ExecutionPolicy -ExecutionPolicy RemoteSigned



git config --global user.name "fifman"
git config --global user.email "1264380449@qq.com"

choco install vim-tux

git clone https://github.com/VundleVim/Vundle.vim.git %USERPROFILE%/vimfiles/bundle/Vundle.vim

choco install cmake
choco install 7zip
choco install ag
choco install ctags

rem build vimproc.vim
choco install mingw
cd .\vimfiles\bundle\vimproc.vim
mingw32-make -f make_mingw64.mak

:: cd %USERPROFILE%/vimfiles/bundle/YouCompleteMe
:: install.py --clang-completer --tern-completer

rem install rename of perl
git clone https://github.com/subogero/rename.git
cd rename
sudo make install
cd ..
rm -rf rename

rem epub reader
rem choco install fbreader

rem install data git repository
<<<<<<< HEAD:Develop/cmd/initenv.bat
mkdir D:\00Data

cd D:\00Data
git init
git remote add github git@github.com:fifman/Data.git
git pull github master
git config --global credential.helper wincred
=======
mkdir D:\00Data

cd D:\00Data
git init
git remote add github git@github.com:fifman/Data.git
git pull github master
git config --global credential.helper wincred
>>>>>>> 7e95ff90d447951476e2675c9db292982deafa14:Develop/cmd/initenv.ps1
