#/bin/sh

brew update
brew upgrade

brew tap caskroom/fonts
brew tap caskroom/cask
brew tap Homebrew/bundle
brew install mas

brew cask install cakebrew

###########
# Browsers
###########
brew cask install google-chrome
brew cask install firefox

###########
# Program
###########
brew cask install virtualbox
brew install nmap

##################
# Editor and IDE
##################
brew cask install intellij-idea
brew cask install clion
brew cask install pycharm
brew cask install rubymine
# brew cask install rider
brew cask install visual-studio-code
brew install neovim/neovim/neovim
brew cask install xamarin-studio
brew cask install android-studio
mas install 497799835 #xcode

brew tap universal-ctags/universal-ctags
brew tap splhack/homebrew-splhack
brew install --HEAD splhack/splhack/macvim-kaoriya
brew install cmigemo

############
# Tools
############
brew cask install google-drive
brew cask install google-japanese-ime
brew cask install keepassxc
mas install 539883307 #line
mas install 803453959 #slack
mas install 410628904 #wunderlist
mas install 784801555 #onenote
mas install 405843582 #alfred
brew cask install iterm2
brew cask install sourcetree
brew install git
brew install bash


###########
# Lang
###########
brew install rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
echo 'if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi' >> ~/.bash_profile
brew install ruby-build
brew install rbenv-gemset
brew install rbenv-gem-rehash

brew install go
brew install pyenv
brew install pyenv-virtualenv
brew install nodebrew
nodebrew setup
echo 'export PATH=$HOME/.nodebrew/current/bin:$PATH' >> ~/.bash_profile
nodebrew install-binary latest
nodebrew use stable


##########
# fonts
##########
brew cask install font-inconsolata-dz-for-powerline
brew cask install font-ricty-diminished
