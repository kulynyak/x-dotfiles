#!/usr/bin/env zsh

export LANG=en_US.UTF-8

# terminal
export TERM=screen-256color

# dotfile aliases
alias dfs="/usr/local/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
alias dfss="dfs status"
alias dfsc='dfs commit -m "$(date -u)" && dfs push'
dfsa() {
    # about add modified files to dots
    dfs add $(dfs status | grep modified | sed 's/\(.*modified:\s*\)//')
}
alias dfsl="dfs ls-tree -r master --name-only"
alias dfsla="dfs log --pretty=format: --name-only --diff-filter=A | sort - | sed '/^$/d'"
DOTS_BKP="$HOME/Dropbox/sync.dotfiles"
alias dotbot="dotbot -c $HOME/dots/install.conf.yaml -d $DOTS_BKP"
alias bbd='brew bundle dump --all --force --file=$HOME/dots/Brewfile'

alias flushdns='sudo killall -HUP mDNSResponder;sudo killall mDNSResponderHelper;sudo dscacheutil -flushcache'

alias urldecode='python3 -c "import sys, urllib.parse as ul; print(ul.unquote_plus(sys.argv[1]))"'

alias urlencode='python3 -c "import sys, urllib.parse as ul; print (ul.quote_plus(sys.argv[1]))"'

# set the github API token for homebrew
HOMEBREW_GITHUB_API_TOKEN_PATH="$HOME/Dropbox/sync.dotfiles/brew.github.token.txt"
[[ -f $HOMEBREW_GITHUB_API_TOKEN_PATH ]] && export HOMEBREW_GITHUB_API_TOKEN=$(<$HOMEBREW_GITHUB_API_TOKEN_PATH)

function up-cask(){
    # about update outdated casks
    OUTDATED=$(brew cask outdated --greedy --verbose|sed -E '/latest/d'|awk '{print $1}' ORS=' '|tr -d '\n')
    echo "outdated=:$OUTDATED:"
    [[ ! -z "$OUTDATED" ]] && brew cask reinstall ${=OUTDATED}
}

function up() {
    # about 'update brew packages'
    brew update
    brew upgrade
    brew cleanup
    ls -l /usr/local/Homebrew/Library/Homebrew | grep homebrew-cask | \
      awk '{print $9}' | for evil_symlink in $(cat -); \
      do rm -v /usr/local/Homebrew/Library/Homebrew/$evil_symlink; done
    brew doctor
  }

function d64(){
    # about 'decode from base64'
    if [ -z "$1" ]; then
        echo "No argument supplied"
        exit 1;
    fi
    echo $1 | base64 -D
}

function e64(){
    # about 'encode to base64'
    if [ -z "$1" ]; then
        echo "No argument supplied"
        exit 1;
    fi
    echo $1 | base64
}

PATH="/usr/local/sbin:/usr/local/bin:/bin:/sbin:/usr/bin:/usr/sbin"

## gnubin
# GNU_BIN="/usr/local/opt/coreutils/libexec/gnubin"
# [[ -d "$GNU_BIN" ]] && PATH="$GNU_BIN:$PATH"

# Java
# export _JAVA_OPTIONS="-Djava.net.preferIPv4Stack=true"
# export JAVA_HOME="$(/usr/libexec/java_home -v 13)"
export JAVA11_HOME="$(/usr/libexec/java_home -v 11)"
# export JAVA13_HOME="$(/usr/libexec/java_home -v 13)"
# export JAVA8_HOME="$(/usr/libexec/java_home -v 1.8)"
# export JAVA7_HOME="$(/usr/libexec/java_home -v 1.7)"

# bin in home dir
HOME_BIN="$HOME/bin"
[[ -d "$HOME_BIN" ]] && PATH="$HOME_BIN:$PATH"

# gem
export GEM_HOME="$HOME/.gem"
if which gem >/dev/null; then
    GEM_PATH=$(ruby -e 'puts Gem.user_dir' | sed s/2.3.0/2.6.0/)
    [[ -d "$GEM_PATH" ]] || mkdir -p $GEM_PATH
    PATH="$GEM_PATH:$GEM_PATH/bin:$PATH"
fi

# gnu man
MANPATH_GNU="/usr/local/opt/findutils/libexec/gnuman"
[[ -d "$MANPATH_GNU" ]] && export MANPATH="$MANPATH_GNU:$MANPATH"

# android
ANDROID_HOME="$HOME/Library/Android/sdk"
if [[ -d "$ANDROID_HOME" ]]; then
    export ANDROID_HOME
    PATH="$ANDROID_HOME/platform-tools:$PATH"
fi

# anaconda3
ANACONDA3="/usr/local/anaconda3/bin"
[[ -d "$ANACONDA3" ]] && PATH="$ANACONDA3:$PATH"

# go
GOROOT="$(brew --prefix golang)/libexec"
if [ -d "$GOROOT" ]; then
    export GOROOT
    export GOPATH="$HOME/.go"
    [[ -d "$GOPATH" ]] || mkdir -p "$GOPATH"
    [[ -d "$GOPATH/src/github.com" ]] || mkdir -p "$GOPATH/src/github.com"
    PATH="$PATH:$GOPATH/bin:$GOROOT/bin"
fi

# ruby
RUBY_PATH="/usr/local/opt/ruby"
if [ -d "$RUBY_PATH" ]; then
    export LDFLAGS="$LDFLAGS -L$RUBY_PATH/lib"
    export CPPFLAGS="$CPPFLAGS -I$RUBY_PATH/include"
    export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:$RUBY_PATH/lib/pkgconfig"
    PATH="$RUBY_PATH/bin:${PATH}"
fi

# icu4c
# ICU4_PATH="/usr/local/opt/icu4c"
# if [ -d "$ICU4_PATH" ]; then
#     export LDFLAGS="$LDFLAGS -L$ICU4_PATH/lib"
#     export CPPFLAGS="$CPPFLAGS -I$ICU4_PATH/include"
#     export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:$ICU4_PATH/lib/pkgconfig"
#     PATH="$ICU4_PATH/bin:$ICU4_PATH/sbin:${PATH}"
# fi

# sqlite
# SQLITE_PATH="/usr/local/opt/sqlite"
# if [ -d "$SQLITE_PATH" ]; then
#     export LDFLAGS="$LDFLAGS -L$SQLITE_PATH/lib"
#     export CPPFLAGS="$CPPFLAGS -I$SQLITE_PATH/include"
#     export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:$SQLITE_PATH/lib/pkgconfig"
#     PATH="$SQLITE_PATH/bin:$PATH"
# fi

# syniverse
# SCG_SRC="$HOME/svn/syniverse/scg"
# [[ -d "$SCG_SRC" ]] && export SCG_SRC

#export KUBECONFIG=$HOME/.kube/config-minikube:$HOME/.kube/config-poc:$HOME/.kube/config-nix

[[ -d /usr/local/opt/mongodb@3.4/bin ]] && PATH="/usr/local/opt/mongodb@3.4/bin:$PATH"

export MOZ_DISABLE_SAFE_MODE_KEY="never"

export M2_HOME=$(command mvn --version | sed 's:.*\(/usr/.*/libexec\).*:\1:gp;d')

export PATH="/usr/local/opt/curl-openssl/bin:$PATH"

export PATH="$PATH:$HOME/hacker1/xsser"

# the last one
export PATH=".:$PATH"
