sudo apt-add-repository ppa:fish-shell/release-3
sudo apt-get update
sudo apt-get upgrade -y
get -O get-docker.sh get.docker.com
sudo sh get-docker.sh

sudo apt-get install vim gdb ripgrep fd cmigemo fish
sudo chsh -s /usr/bin/fish
