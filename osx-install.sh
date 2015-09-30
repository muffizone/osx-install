#!/bin/sh
set -e

prompt () {
    echo "$@"
    echo "Press Enter to continue..."
    read
}

prompt "Install brew?"
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

prompt "Install ruby?"
brew install ruby

prompt "Install git?"
brew install git

prompt "Update brew + brew doctor now?"
brew update 
brew doctor 

# Tap some kegs
brew tap homebrew/versions
brew tap homebrew/science
# brew tap caskroom/fonts

prompt "Install python?"
brew install python

prompt "Install vim?"
brew install vim

prompt "Install fish?"
brew install fish

# brew install caskroom/cask/brew-cask
brew install bup
brew install cowsay
brew install ctags
brew install direnv
brew install elasticsearch
# brew install fdupes
brew install ffind
brew install fish
brew install gcc
# brew install homebrew/versions/gcc46
# brew install gist
brew install gnupg
brew install graphviz
brew install hub
brew install imagemagick
brew install jq
# brew install leiningen
brew install libevent
brew install macvim
# brew install homebrew/versions/mongodb24
brew install moreutils
# brew install mysql
# brew install nginx
brew install node
brew install optipng
# brew install par2
brew install pdfgrep
brew install pngquant
brew install pv
# brew install rabbitmq
brew install reattach-to-user-namespace
brew install redis
brew install selecta
brew install the_silver_searcher
brew install tig
brew install tree
brew install unrar
brew install watch
brew install wget
brew install zeromq

# Casks
brew install brew-cask

function installcask() {
    if brew cask info "$@" | grep "Not installed" > /dev/null; then
        brew cask install "$@"
    else
        echo "$@ is already installed."
    fi
}

installcask alfred
installcask arq
installcask daisydisk
installcask dropbox
installcask firefox
installcask fluid
installcask flux
installcask heroku-toolbelt
installcask iterm2
installcask licecap
installcask mailplane
installcask mongohub
installcask nvalt
installcask postgres
installcask postico
installcask screenhero
installcask skype
installcask vlc
# installcask wireshark
installcask zooom
