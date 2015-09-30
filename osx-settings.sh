#!/bin/sh
set -e

# Dock
defaults write com.apple.dock orientation -string "left"

# Show battery percentage
defaults write com.apple.menuextra.battery ShowPercent -string "YES"

# Hot corners
# Possible values:
#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center

# Top left screen corner
defaults write com.apple.dock wvous-tl-corner -int 6
defaults write com.apple.dock wvous-tl-modifier -int 0

# Top right screen corner
defaults write com.apple.dock wvous-tr-corner -int 10
defaults write com.apple.dock wvous-tr-modifier -int 0

# Bottom left screen corner
defaults write com.apple.dock wvous-bl-corner -int 0
defaults write com.apple.dock wvous-bl-modifier -int 0

# Bottom left screen corner
defaults write com.apple.dock wvous-br-corner -int 4
defaults write com.apple.dock wvous-br-modifier -int 0

killall Dock
killall SystemUIServer
