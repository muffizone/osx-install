#!/bin/sh
set -e

# Dock
defaults write com.apple.dock orientation -string "left"
killall Dock

# Show battery percentage
defaults write com.apple.menuextra.battery ShowPercent -string "YES"
