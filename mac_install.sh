#!/bin/bash

if [ "$(uname)" != 'Darwin' ]; then
    echo "This script is work on only macOS!" >&2
    exit 1
fi

DOTDIR="${HOME}/dotfiles"

# show dotfile
defaults write com.apple.finder AppleShowAllFiles -boolean true
killall Finder

cd "${DOTDIR}"

# install softwares
source "${DOTDIR}/mac_brew.sh"

# create sym-link
mkdir ~/.vim
ln -si ./.bashrc ~/.bashrc
ln -si ./.vimrc ~/.vimrc
ln -si ./.gvimrc ~/.gvimrc
ln -si ./dein.toml ~/.vim/dein.toml
ln -si ~/Google\ Drive/.ssh ~/.ssh

cd /usr/local/Cellar/git/*/etc/bash_completion.d/

sudo mkdir -p /usr/local/git/contrib/complation/
sudo mv git-completion.bash /usr/local/git/contrib/complation/
sudo mv git-prompt.sh /usr/local/git/contrib/complation/
