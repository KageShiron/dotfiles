#!/bin/bash
sudo apt-add-repository -y ppa:fish-shell/release-3
sudo apt-get update
sudo apt-get upgrade -y
wget -O get-docker.sh get.docker.com
sudo sh get-docker.sh

sudo apt-get install -y vim gdb ripgrep fd-find cmigemo fish \
  coreutils automake autoconf openssl \
  unzip curl hub peco\
  autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev

git clone https://github.com/asdf-vm/asdf.git ~/.asdf
cd ~/.asdf
git checkout "$(git describe --abbrev=0 --tags)"

echo '. $HOME/.asdf/asdf.sh' > ~/.bashrc
. $HOME/.asdf/asdf.sh

export GNUPGHOME="${ASDF_DIR:-$HOME/.asdf}/keyrings/nodejs" && mkdir -p "$GNUPGHOME" && chmod 0700 "$GNUPGHOME"

# Imports Node.js release team's OpenPGP keys to the keyring
bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring

asdf update
asdf plugin add ruby
asdf plugin add python
asdf plugin add nodejs
asdf plugin add golang

asdf install ruby latest
asdf install python latest
asdf install nodejs latest
asdf install golang latest

asdf global ruby (asdf list ruby)
asdf global python (asdf list python)
asdf global nodejs (asdf list nodejs)
asdf global golang (asdf list golang)

sudo chsh -s /usr/bin/fish