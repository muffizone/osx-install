#!/bin/sh
set -e

warn () {
    echo "WARNING: $1" >&2
}


die () {
    echo "FATAL: $1" >&2
    exit 2
}


fail_if_empty () {
    empty=1
    while read line; do
        echo "$line"
        empty=0
    done
    test $empty -eq 0
}


_check_brew_package_installed () {
    brew list --versions $(basename "$1") | fail_if_empty > /dev/null
}


_update_brew() {
    if [ -f ".brew_updated" ]; then
        return  # bail out -- already done
    fi

    trap "{ rm -f .brew_updated; exit 255; }" EXIT
    touch .brew_updated

    echo "Updating brew to have the latest packages... hang in there..."
    brew update && \
        echo "homebrew packages updated" || \
        die "could not update brew"
}


brew_me_some () {
    pkg="$1"
    _check_brew_package_installed "$pkg" || \
        (_update_brew && brew install "$pkg") || \
        die "$pkg could not be installed"

    echo "$pkg installed"
}


cask_me_some () {
    pkg="$1"
    brew cask list | grep -qxF "$pkg" || \
        brew cask install "$@" || \
        die "cask $pkg could not be installed"
    echo "$@ is already installed."
}


check_brew_is_installed () {
    if ! which -s brew; then
        echo "We rely on the Brew installer for the Mac OS X platform."
        echo "Please install Brew by following instructions here:"
        echo "    http://brew.sh/#install"
        echo ""
        exit 2
    fi
}


install_tools () {
    check_brew_is_installed

    # Used by brew
    brew_me_some ruby
    brew_me_some git

    # Tap some kegs
    echo ""
    echo "#######################################################"
    echo "# KEGS"
    echo "#######################################################"
    brew tap homebrew/versions
    brew tap homebrew/science
    brew tap caskroom/versions

    echo ""
    echo "#######################################################"
    echo "# INSTALLING BREW PACKAGES"
    echo "#######################################################"
    brew_me_some pyenv
    brew_me_some vim
    brew_me_some zsh

    brew_me_some colordiff
    brew_me_some direnv
    brew_me_some ffind
    brew_me_some gcc
    brew_me_some gnupg
    brew_me_some graphviz
    brew_me_some jq
    brew_me_some ssh-copy-id
    brew_me_some tree
    brew_me_some unrar
    brew_me_some watch
    brew_me_some wget
    brew_me_some node
    brew_me_some tldr
}


install_casks () {
    echo ""
    echo "#######################################################"
    echo "# CASKS"
    echo "#######################################################"
    brew_me_some caskroom/cask/brew-cask

    cask_me_some bitwarden
    cask_me_some iterm2
    cask_me_some pycharm
    cask_me_some sublime-text
    cask_me_some htop
    cask_me_some docker
    cask_me_some docker-compose
#    cask_me_some mongohub
#    cask_me_some nvalt
#    cask_me_some postgres
#    cask_me_some postico
#    cask_me_some rescuetime
#    cask_me_some robomongo
#    cask_me_some screenflow
#    cask_me_some screenhero
    cask_me_some slack
    cask_me_some spotify
    cask_me_some wireshark
}


install_fonts () {
    echo ""
    echo "#######################################################"
    echo "# FONTS"
    echo "#######################################################"

    brew tap caskroom/fonts

    # The fonts
    cask_me_some font-anonymous-pro
    cask_me_some font-hack
    cask_me_some font-inconsolata
    cask_me_some font-pt-mono
    cask_me_some font-roboto
    cask_me_some font-source-code-pro-for-powerline
    cask_me_some font-ubuntu-mono-powerline
}


main () {
    install_tools
    install_casks
    install_fonts
}

main
