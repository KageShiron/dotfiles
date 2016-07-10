#!/bin/sh

askYesOrNo() {
    while true ; do
        read -p "$1 (y/n)?" answer
        case $answer in
            [yY] | [yY]es | YES )
                return 0;;
            [nN] | [nN]o | NO )
                return 1;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}

if [ -ne "~/.vim" ]; then
    mkdir ~/.vim
fi

ln -si ~/dotfiles/.vimrc ~/.vimrc
ln -si ~/dotfiles/.gvimrc ~/.gvimrc
ln -si ~/dotfiles/dein.toml ~/.vim/dein.toml

type apt-get
apt=$?
type cmigemo

if [ $apt -e 0 && $? -ne 0 ]; then
    askYesOrNo "Do you want to run \"sudo apt-get install cmigemo\"?"
    if [ $? -e 0 ]; then
        sudo apt-get install cmigemo
    fi
fi

