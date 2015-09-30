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
    brew list --versions "$1" | fail_if_empty > /dev/null
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


check_brew_is_installed () {
    if ! which -s brew; then
        echo "We rely on the Brew installer for the Mac OS X platform."
        echo "Please install Brew by following instructions here:"
        echo "    http://brew.sh/#install"
        echo ""
        exit 2
    fi
}


main () {
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
    # brew tap caskroom/fonts

    echo ""
    echo "#######################################################"
    echo "# INSTALLING BREW PACKAGES"
    echo "#######################################################"
    brew_me_some python
    brew_me_some vim
    brew_me_some fish

    brew_me_some bup
    brew_me_some cowsay
    brew_me_some ctags
    brew_me_some direnv
    # brew_me_some fdupes
    brew_me_some ffind
    brew_me_some fish
    brew_me_some gcc
    # brew_me_some homebrew/versions/gcc46
    # brew_me_some gist
    brew_me_some gnupg
    brew_me_some graphviz
    brew_me_some hub
    brew_me_some imagemagick
    brew_me_some jq
    # brew_me_some leiningen
    brew_me_some libevent
    brew_me_some macvim
    # brew_me_some homebrew/versions/mongodb24
    brew_me_some moreutils
    # brew_me_some mysql
    # brew_me_some nginx
    brew_me_some node
    brew_me_some optipng
    # brew_me_some par2
    brew_me_some pdfgrep
    brew_me_some pngquant
    brew_me_some pv
    # brew_me_some rabbitmq
    brew_me_some reattach-to-user-namespace
    brew_me_some redis
    brew_me_some selecta
    brew_me_some the_silver_searcher
    brew_me_some tig
    brew_me_some tree
    brew_me_some unrar
    brew_me_some watch
    brew_me_some wget
    brew_me_some zeromq

    # brew_me_some elasticsearch  # TODO: requires Java

    # Casks
    brew_me_some caskroom/cask/brew-cask

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
    # installcask zooom
}

main
