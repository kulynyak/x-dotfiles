export __OS__=$(uname)
unset PATH

PATH="/usr/local/sbin:/usr/local/bin:/bin:/sbin:/usr/bin:/usr/sbin"

alias dotfiles='/usr/local/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
DOTS_BKP="$HOME/Dropbox/sync.dotfiles"
alias dotbot="dotbot -c $HOME/dots/install.conf.yaml -d $DOTS_BKP"

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

# aliases definition
alias rm='trash'
alias vim='nvim'
alias vi='command nvim'
alias cls='clear'
alias history='fc -l 1'
alias md='mkdir -p'
alias pgrep="pgrep -f"
alias pkill="pkill -9 -f"

# share folder
alias wshare='python3 -m http.server'

# long view, show hidden
alias l='ls -Glah'

# compact view, show hidden
alias la='ls -GAF'

# long view, no hidden
alias ll='ls -GlFh'
alias sl='ls -G'
alias ls='ls -G'
alias less='less -R'
alias diff='colordiff -u'
alias cls="clear"
alias top='htop'

# opening ports
alias port='netstat -ntlp tcp'

# show directories size
alias dud='du -s *(/)'
alias x='exit'

# alias jupyter='jupyter_mac.command exit'

# kubernetes
alias k='kubectl'
alias mk='/usr/local/bin/minikube'

alias of='open .'

alias c='lolcat'

alias h='head'

alias npms='npm start -- --reset cache .'
alias npmr='npm run'

alias gw='./gradlew'

# alias redshift="killall redshift;redshift -t 5800:5100 -l 49:32 -g 0.95 -b .95>/dev/null 2>&1 &"

alias ip='ifconfig | grep "inet " | grep -Fv 127.0.0.1 | awk '\''{print $2}'\'

if [[ "$OSTYPE" == "darwin"* ]]; then
  # Show/Hide Hidden Files mac OS X
  alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app > /dev/null 2>&1'
  alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.appi >/dev/null 2>&1'
  # OPEN FOLDER
  alias n='open .'
  alias simulator='open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app'
  function pfd() {
    osascript 2>/dev/null <<EOF
      tell application "Finder"
        return POSIX path of (target of first window as text)
      end tell
EOF
  }
elif [[ "$OSTYPE" == "linux-gnu" ]]; then
  # OPEN FOLDER
  alias n='nautilus'
fi

function fn() {
  find . -name "$1" -print 2>&1 | grep -v -Ei 'Operation not permitted|Permission denied|Not a directory'
}

# change to parent directory matching partial string, eg:
# in directory /home/foo/bar/baz, 'bd f' changes to /home/foo
function bd() {
  local old_dir=$(pwd)
  local new_dir=$(echo $old_dir | sed 's|\(.*/'$1'[^/]*/\).*|\1|')
  index=$(echo $new_dir | awk '{ print index($1,"/'$1'"); }')
  if [ $index -eq 0 ]; then
    echo "No such occurrence."
  else
    echo $new_dir
    cd "$new_dir"
  fi
}

function up() {
  brew update
  brew upgrade
  brew cleanup
  ls -l /usr/local/Homebrew/Library/Homebrew | grep homebrew-cask | awk '{print $9}' | for evil_symlink in $(cat -); do rm -v /usr/local/Homebrew/Library/Homebrew/$evil_symlink; done
  brew doctor
}

function man() {
  env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    PAGER=/usr/bin/less \
    _NROFF_U=1 \
    PATH=${HOME}/bin:${PATH} \
    man "$@"
}

function colours() {
  for i in {0..255}; do
    printf "\x1b[38;5;${i}mcolour${i}\n"
  done
}
