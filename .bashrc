PATH="/usr/local/sbin:/usr/local/bin:/bin:/sbin:/usr/bin:/usr/sbin"

# Java
export _JAVA_OPTIONS="-Djava.net.preferIPv4Stack=true"
export JAVA_HOME="$(/usr/libexec/java_home -v 11)"
export JAVA11_HOME="$(/usr/libexec/java_home -v 11)"
export JAVA12_HOME="$(/usr/libexec/java_home -v 12)"
# export JAVA8_HOME="$(/usr/libexec/java_home -v 1.8)"
# export JAVA7_HOME="$(/usr/libexec/java_home -v 1.7)"

# bin in home dir
HOME_BIN="$HOME/bin"
[ -d "$HOME_BIN" ] && PATH="$HOME_BIN:$PATH"

# gem
GEM_HOME="$HOME/.gem"
GEM_PATH="$GEM_HOME/bin"
if [ -d "$GEM_HOME" ] && [ -d "$GEM_PATH"]; then
    export GEM_HOME
    export GEM_PATH
    PATH="$PATH:$GEM_PATH"
fi

# gnu man
MANPATH_GNU="/usr/local/opt/findutils/libexec/gnuman"
if [ -d "$MANPATH_GNU" ]; then
    export MANPATH="$MANPATH_GNU:$MANPATH"
fi

# android
ANDROID_HOME="/usr/local/share/android-sdk"
if [ -d "$ANDROID_HOME" ]; then
    export ANDROID_HOME
    PATH="$ANDROID_HOME/platform-tools:$PATH"
fi

# anaconda3
ANACONDA3="/usr/local/anaconda3/bin"
if [ -d "$ANACONDA3" ]; then
    PATH="$ANACONDA3:$PATH"
fi

# go
GOROOT="$(brew --prefix golang)/libexec"
if [ -d "$GOROOT" ]; then
    export GOROOT
    export GOPATH="$HOME/.go"
    [ -d "$GOPATH" ] || mkdir -p "$GOPATH"
    [ -d "$GOPATH/src/github.com" ] || mkdir -p "$GOPATH/src/github.com"
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
ICU4_PATH="/usr/local/opt/icu4c"
if [ -d "$ICU4_PATH" ]; then
    export LDFLAGS="$LDFLAGS -L$ICU4_PATH/lib"
    export CPPFLAGS="$CPPFLAGS -I$ICU4_PATH/include"
    export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:$ICU4_PATH/lib/pkgconfig"
    PATH="$ICU4_PATH/bin:$ICU4_PATH/sbin:${PATH}"
fi

# sqlite
SQLITE_PATH="/usr/local/opt/sqlite"
if [ -d "$SQLITE_PATH" ]; then
    export LDFLAGS="$LDFLAGS -L$SQLITE_PATH/lib"
    export CPPFLAGS="$CPPFLAGS -I$SQLITE_PATH/include"
    export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:$SQLITE_PATH/lib/pkgconfig"
    PATH="$SQLITE_PATH/bin:$PATH"
fi

# syniverse
SCG_SRC="$HOME/svn/syniverse/scg"
if [ -d "$SCG_SRC" ]; then
    export SCG_SRC
fi

# the last one
export PATH

# dotfiles
alias dfs="/usr/local/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
alias dfss="dfs status"
alias dfsc='dfs commit -m "$(date -u)" && dfs push'
dfsa() {
    dfs add $(dfs status | grep modified | sed 's/\(.*modified:\s*\)//')
}
alias dfsl="dfs ls-tree -r master --name-only"
alias dfsla="dfs log --pretty=format: --name-only --diff-filter=A | sort - | sed '/^$/d'"
DOTS_BKP="$HOME/Dropbox/sync.dotfiles"
alias dotbot="dotbot -c $HOME/dots/install.conf.yaml -d $DOTS_BKP"
