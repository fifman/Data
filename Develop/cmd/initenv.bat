git config --global user.name "fifman"
git config --global user.email "1264380449@qq.com"

git clone https://github.com/VundleVim/Vundle.vim.git %USERPROFILE%/vimfiles/bundle/Vundle.vim

choco install cmake
choco install 7zip
choco install ag
choco install ctags

cd %USERPROFILE%/vimfiles/bundle/YouCompleteMe
install.py --clang-completer --tern-completer
