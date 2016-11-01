
$devHome = "D:\00Data\Develop"
$devInstall = "D:\10bin";




function {
    choco install vim-tux
    git clone https://github.com/VundleVim/Vundle.vim.git %USERPROFILE%\vimfiles\bundle\Vundle.vim
    choco install ctags
}

choco install ag
choco install everything
choco install jdk8
choco install mongodb

rem epub reader
choco install fbreader

function {
    rem install rename of perl
    git clone https://github.com/subogero/rename.git
    cd rename
    sudo make install
    cd ..
    rm -rf rename
}


function {
    rem install data git repository
    mkdir D:\00Data
    cd D:\00Data
    git init
    git remote add github git@github.com:fifman/Data.git
    git pull github master
    git config --global credential.helper wincred
}

function Set-PS-Environment {
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
    '$Env:PSModulePath = $Env:PSModulePath + ";" + "' + $devHome + '" + "\powershell\Modules\"' >> $PROFILE.CurrentUserAllHosts
}

function Install-Choco {
    '$Env:ChocolateyInstall = "' + $devInstall + '" + "\Chocolatey"' >> $PROFILE.CurrentUserAllHosts
    '$Env:ChocolateyBinRoot =  $Env:ChocolateyInstall + "\tools"' >> $PROFILE.CurrentUserAllHosts
    iwr https://chocolatey.org/install.ps1 -UseBasicParsing | iex
    choco feature enable -n=allowGlobalConfirmation
}

function Install-Git {
    choco install git
    git config --global user.name "fifman"
    git config --global user.email "1264380449@qq.com"

}

function Install-YCM {
    choco install cmake
    choco install 7zip
    choco install nodejs
    rem build vimproc.vim
    choco install mingw
    cd .\vimfiles\bundle\vimproc.vim
    mingw32-make -f make_mingw64.mak
    cd %USERPROFILE%\vimfiles\bundle/YouCompleteMe
    install.py --clang-completer --tern-completer

}
