export __OS__=$(uname)
unset PATH

PATH="/usr/local/sbin:/usr/local/bin:/bin:/sbin:/usr/bin:/usr/sbin"


alias dotfiles='/usr/local/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
DOTS_BKP="$HOME/Dropbox/sync.dotfiles"
alias dotbot="dotbot -c $HOME/dots/install.conf.yaml -d ${=DOTS_BKP}"

export NCURSES_NO_UTF8_ACS=1

PATH="$HOME/bin:$PATH"

# Java
export _JAVA_OPTIONS="-Djava.net.preferIPv4Stack=true"
export JAVA_HOME="$(/usr/libexec/java_home -v 11)"
export JAVA11_HOME="$(/usr/libexec/java_home -v 11)"
export JAVA12_HOME="$(/usr/libexec/java_home -v 12)"
# export JAVA8_HOME="$(/usr/libexec/java_home -v 1.8)"
# export JAVA7_HOME="$(/usr/libexec/java_home -v 1.7)"

# Android
export ANDROID_HOME=/usr/local/share/android-sdk
PATH="$ANDROID_HOME/platform-tools:$PATH"

# gem
export GEM_HOME="$HOME/.gem"
export GEM_PATH="$GEM_HOME/bin"
export PATH="$PATH:$GEM_PATH"

# editors
export EDITOR='vim'
export VISUAL='vim'
export PAGER='less'

## language
if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi

export MANPATH="/usr/local/opt/findutils/libexec/gnuman:${MANPATH}"

# Setting PATH for Anaconda3
PATH="/usr/local/anaconda3/bin:${PATH}"

# minikube
alias k='kubectl'
alias mk='/usr/local/bin/minikube'

# Go development
export GOPATH="${HOME}/.go"
export GOROOT="$(brew --prefix golang)/libexec"
PATH="${PATH}:${GOPATH}/bin:${GOROOT}/bin"
test -d "${GOPATH}" || mkdir "${GOPATH}"
test -d "${GOPATH}/src/github.com" || mkdir -p "${GOPATH}/src/github.com" 

# Ruby
PATH="/usr/local/opt/ruby/bin:${PATH}"
export LDFLAGS="${LDFLAGS} -L/usr/local/opt/ruby/lib"
export CPPFLAGS="${CPPFLAGS} -I/usr/local/opt/ruby/include"
export PKG_CONFIG_PATH="${PKG_CONFIG_PATH}:/usr/local/opt/ruby/lib/pkgconfig"

# icu4c
PATH="/usr/local/opt/icu4c/bin:${PATH}" 
PATH="/usr/local/opt/icu4c/sbin:${PATH}"
LDFLAGS="${LDFLAGS} -L/usr/local/opt/icu4c/lib"
export CPPFLAGS="${CPPFLAGS}-I/usr/local/opt/icu4c/include"
export PKG_CONFIG_PATH="${PKG_CONFIG_PATH}:/usr/local/opt/icu4c/lib/pkgconfig"

# sqlite
PATH="/usr/local/opt/sqlite/bin:${PATH}"
LDFLAGS="${LDFLAGS} -L/usr/local/opt/sqlite/lib"
export CPPFLAGS="${CPPFLAGS}-I/usr/local/opt/sqlite/include"
export PKG_CONFIG_PATH="${PKG_CONFIG_PATH}:/usr/local/opt/sqlite/lib/pkgconfig"
 
# Syniverse
export SCG_SRC="${HOME}/svn/syniverse/scg"

# The last line to export PATH
export PATH

