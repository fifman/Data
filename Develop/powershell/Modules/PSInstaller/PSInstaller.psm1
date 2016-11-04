
$devHome = "D:\00Data\Develop"
$devInstall = "D:\10bin";

rem "test dosbatch file syntax!"

function Set-PS-Environment {
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
    rm -fo $PROFILE.CurrentUserAllHosts
    '$Env:PSModulePath = $Env:PSModulePath + ";" + "' + $devHome + '" + "\powershell\Modules\"' >> $PROFILE.CurrentUserAllHosts
}

function Install-Choco {
    '$Env:ChocolateyInstall = "' + $devInstall + '" + "\Chocolatey"' >> $PROFILE.CurrentUserAllHosts
    '$Env:ChocolateyBinRoot =  $Env:ChocolateyInstall + "\tools"' >> $PROFILE.CurrentUserAllHosts
    iwr https://chocolatey.org/install.ps1 -UseBasicParsing | iex
    choco feature enable -n=allowGlobalConfirmation
    choco feature enable -n=allowEmptyChecksums
}

function Install-Git {
    choco install git
    git config --global user.name "fifman"
    git config --global user.email "1264380449@qq.com"
    git config --global credential.helper wincred
}

function Install-Tools {
    choco install cmake
    choco install python
    choco install strawberryperl
    choco install nodejs
}

function Install-Repo {
    rem install data git repository
    git clone https://github.com/fifman/Data.git D:\00Data
}

function Install-Vim {
    choco install vim-tux
    git clone https://github.com/VundleVim/Vundle.vim.git ~\vimfiles\bundle\Vundle.vim
    choco install ctags
    vim -c ":PluginInstall" -c ":qa"
}

function Install-Ag {
    choco install ag
    rem build vimproc.vim
    choco install mingw
    cd ~\vimfiles\bundle\vimproc.vim
    mingw32-make -f make_mingw64.mak
}







function Install-YCM {
    choco install 7zip
    cd ~\vimfiles\bundle\YouCompleteMe
    python install.py --clang-completer --tern-completer

}



function Install-Rename {
    rem install rename of perl
    git clone https://github.com/subogero/rename.git
    cd rename
    sudo make install
    cd ..
    rm -r -fo rename
}


function Install-Softwares {
    choco install everything
    choco install jdk8
    choco install mongodb
    rem epub reader
    choco install fbreader
}


export-modulemember -function Set-PS-Environment
export-modulemember -function Install-Choco
export-modulemember -function Install-Git
export-modulemember -function Install-Vim
export-modulemember -function Install-Ag
export-modulemember -function Install-YCM
export-modulemember -function Install-Rename
export-modulemember -function Install-Repo
export-modulemember -function Install-Softwares
export-modulemember -function Install-Tools
