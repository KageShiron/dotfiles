#!/usr/bin/env bash

set -e

if ! command -v defaults > /dev/null 2>&1; then
    echo "\`defaults\` not found. Nothing to do."
    exit 0
fi

echo "Configuring..."
defaults write com.apple.dock orientation left "left"
defaults write -g NSAutomaticWindowAnimationsEnabled -bool false 
defaults write -g NSWindowResizeTime 0.1 
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

defaults write com.apple.finder AppleShowAllFiles YES
defaults write com.apple.finder QLEnableTextSelection -bool true
defaults write com.apple.Finder QuitMenuItem -bool true
defaults write com.apple.finder ShowTabView -bool true 
defaults write com.apple.finder ShowStatusBar -bool true 
defaults write com.apple.finder ShowPathbar -bool true

defaults write com.apple.menuextra.battery ShowPercent -string "YES"

defaults write com.apple.keyboard.fnState -boolean true

defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerHorizSwipeGesture -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadFourFingerHorizSwipeGesture -int 2

# 4Fingers Mission Control
defaults write com.apple.AppleMultitouchTrackpad  TrackpadFourFingerVertSwipeGesture -int 2
defaults write com.apple.AppleMultitouchTrackpad  TrackpadThreeFingerVertSwipeGesture -int 0
defaults write com.apple.dock  showMissionControlGestureEnabled -boolean true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad  TrackpadFourFingerVertSwipeGesture -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad  TrackpadThreeFingerVertSwipeGesture -int 0

# 4Fingers Expose
defaults write com.apple.AppleMultitouchTrackpad  TrackpadFourFingerVertSwipeGesture -int 2
defaults write com.apple.AppleMultitouchTrackpad  TrackpadThreeFingerVertSwipeGesture -int 0
defaults write com.apple.dock  showAppExposeGestureEnabled -boolean true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadFourFingerVertSwipeGesture -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerVertSwipeGesture -int 0


killall SystemUIServer
killall Dock
killall Finder
killall Safari

echo ""
echo "Configuration Complete!"
echo "Please restart Mac to make sure settings are reflected."
