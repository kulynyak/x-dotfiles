#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

autoload -U add-zsh-hook

# global aliases
alias -g  G='|& grep -E -i'
alias -g  L="| less"
alias -g  X='| xargs'
alias -g X0='| xargs -0'
alias -g  C='| wc -l'
alias -g  A='| awk'
alias -g  H='| head -n $(($LINES-5))'
alias -g  T='| tail -n $(($LINES-5))'
alias -g  S='| sed'
alias -g  N='&> /dev/null'
alias -g XC='&> xclip -i -sel c'
# last modified(inode time) file or directory
alias -g NF="./*(oc[1])"

function take() {
  [ $# -eq 1 ]  && mkdir "$1" && cd "$1"
}

if (( $+commands[fasd] )) ; then
  alias f='fasd -f'
  # interactive file selection
  alias sf='fasd -sif'
  # interactive directory selection
  # alias j='fasd -sid'
  # changes the current working directory interactively.
  alias j='fasd_cd -i'
  # show / search / select
  alias s='fasd -si'
  # quick opening files with vim
  alias v='sf -e vim'
  # quick opening files with vim
  alias v='f -t -e vim -b viminfo'
fi

eval $(thefuck --alias zz)

# aliases definition
alias rm='trash'
# alias vim='mvim'
alias vi='command vim'
alias cls='clear'
alias history='fc -l 1'
alias md='mkdir -p'
alias pgrep="pgrep -f"
alias pkill="pkill -9 -f"
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

# reload zsh configuration
alias zreload='exec zsh'
alias of='open .'
alias c='lolcat'
alias h='head'
alias npms='npm start -- --reset cache .'
alias npmr='npm run'
alias gw='./gradlew'
alias redshift="killall redshift;redshift -t 5800:5100 -l 49:32 -g 0.95 -b .95>/dev/null 2>&1 &"
alias ip='ifconfig | grep "inet " | grep -Fv 127.0.0.1 | awk '\''{print $2}'\'

alias k='kubectl'
alias mk='/usr/local/bin/minikube'

if [[ "$OSTYPE" == darwin* ]] ; then
  # alias ssh='ssh -oKexAlgorithms=+diffie-hellman-group1-sha1'
  alias ossh='/usr/bin/ssh'
  # Show/Hide Hidden Files mac OS X
  alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app > /dev/null 2>&1'
  alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.appi >/dev/null 2>&1'
  # MELD
  # alias meld='open -a Meld --args'
  # alias meldw='open -W -a Meld --args'
  # P4Merge
  # alias p4merge='/Applications/p4merge.app/Contents/MacOS/p4merge'
  # OPEN FILE
  alias -s html=open
  alias -s pdf=open
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
fi
if [ "$__OS__" = "Linux" ]; then
  # OPEN FILE
  alias -s html=firefox
  alias -s pdf=evince
  # OPEN FOLDER
  alias n='nautilus'
fi

bindkey -e

# Colors
autoload colors; colors;
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

autoload -U edit-command-line
zle -N edit-command-line

# add sudo before command with alt+s, esc+esc
function prepend-sudo() {
    [[ -z $BUFFER ]] && zle up-history
    if [[ $BUFFER == sudo\ * ]]; then
        LBUFFER="${LBUFFER#sudo }"
    else
        LBUFFER="sudo $LBUFFER"
    fi
}
zle -N prepend-sudo
# Defined shortcut keys: [Esc] [Esc]
bindkey "\e\e" prepend-sudo
# Defined shortcut keys: [Alt-s]
bindkey "^[s" prepend-sudo

zle -N prepend-sudo
bindkey "^[s" prepend-sudo
bindkey "\e\e" prepend-sudo

# change to parent directory matching partial string, eg:
# in directory /home/foo/bar/baz, 'bd f' changes to /home/foo
function bd () {
  local old_dir=`pwd`
  local new_dir=`echo $old_dir | sed 's|\(.*/'$1'[^/]*/\).*|\1|'`
  index=`echo $new_dir | awk '{ print index($1,"/'$1'"); }'`
  if [ $index -eq 0 ] ; then
    echo "No such occurrence."
  else
    echo $new_dir
    cd "$new_dir"
  fi
}

function globalias() {
   if [[ ${LBUFFER} =~ ' [A-Z0-9]+$' ]]; then
     zle _expand_alias
     zle expand-word
   fi
   zle self-insert
}
zle -N globalias
bindkey " " globalias

# ctrl+space to bypass completion
# bindkey "^ " magic-space

# space during searches
bindkey -M isearch " " magic-space

# quick jumping to n-th arguments by pressing alt+number(does not not work in tmux) or esc+number
bindkey '^[1' beginning-of-line
bindkey -s '^[2' '^A^[f'
bindkey -s '^[3' '^A^[f^[f'
bindkey -s '^[4' '^A^[f^[f^[f'
bindkey -s '^[5' '^A^[f^[f^[f^[f'
bindkey -s '^[6' '^A^[f^[f^[f^[f^[f'
bindkey -s '^[7' '^A^[f^[f^[f^[f^[f^[f'
bindkey -s '^[8' '^A^[f^[f^[f^[f^[f^[f^[f'
bindkey -s '^[9' '^A^[f^[f^[f^[f^[f^[f^[f^[f'

# home and end keys
bindkey '\e[1~' beginning-of-line
bindkey '\e[4~' end-of-line

autoload -Uz copy-earlier-word
zle -N copy-earlier-word
bindkey "^[m"    copy-earlier-word

bindkey '^F' forward-word
bindkey '^B' backward-word

# bindkey '^R'     history-incremental-search-backward
# bindkey '^[r'    history-incremental-search-backward

bindkey '^[[5~'  up-line-or-history
bindkey '^[[6~'  down-line-or-history

bindkey '^[[A'   up-line-or-search
bindkey '^[[B'   down-line-or-search

bindkey '^[[H'   beginning-of-line
bindkey '^[[1~'  beginning-of-line

bindkey '^[[F'   end-of-line
bindkey '^[[4~'  end-of-line

bindkey '^[[Z'   reverse-menu-complete

bindkey '^[[3~'  delete-char
bindkey '^[3;5~' delete-char
bindkey '\e[3~'  delete-char

bindkey '^[^I'   _history-complete-older
bindkey '^[^[^I' _history-complete-newer

bindkey '^U'     backward-kill-line

# Completion
setopt MENU_COMPLETE
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

function fn() {
  find . -name "$1"
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

function foreground-current-job() {
  fg;
}
zle -N foreground-current-job
bindkey -M emacs '^z' foreground-current-job

# This bunch of code displays red dots when autocompleting a command with the tab key, "Oh-my-zsh"-style.
function expand-or-complete-with-dots() {
  echo -n "\e[31m......\e[0m"
  zle expand-or-complete
  zle redisplay
}
zle -N expand-or-complete-with-dots
bindkey "^I" expand-or-complete-with-dots

autoload colors; colors;
export LSCOLORS="Gxfxcxdxbxegedabagacad"
export CLICOLOR=true

function colours() {
    for i in {0..255} ; do
        printf "\x1b[38;5;${i}mcolour${i}\n"
    done
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f /usr/local/opt/fzf/shell/key-bindings.zsh ] && source /usr/local/opt/fzf/shell/key-bindings.zsh
[ -f ~/github/zsh/alias-tips/alias-tips.plugin.zsh ] && source ~/github/zsh/alias-tips/alias-tips.plugin.zsh
[ -f ~/github/zsh/ra-git.zsh/ra-git.plugin.zsh ] && source ~/github/zsh/ra-git.zsh/ra-git.plugin.zsh

[ -f ~/github/zsh/ra-mvn.zsh/ra-mvn.plugin.zsh ] && ~/github/zsh/ra-mvn.zsh/ra-mvn.plugin.zsh


if [ /usr/local/bin/kubectl ]; then source <(kubectl completion zsh); fi
export PATH="/usr/local/opt/apr/bin:$PATH"
