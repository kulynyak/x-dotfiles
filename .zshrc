#!/usr/bin/env zsh

# colors
autoload colors
export LSCOLORS="Gxfxcxdxbxegedabagacad"
export CLICOLOR=1


# environment
source ~/.profile

# keyoard
zmodload zsh/complist
bindkey -e
bindkey '^R'      history-incremental-search-backward
bindkey "^[[5~"   up-line-or-history
bindkey "^[[6~"   down-line-or-history
bindkey "^[OH"    beginning-of-line
bindkey "^[[H"    beginning-of-line
bindkey "^[OF"    end-of-line
bindkey "^[[F"    end-of-line
bindkey '^[[1;5C' forward-word
bindkey '^[[C'    forward-word
bindkey '^[[1;5D' backward-word
bindkey '^[[D'    backward-word
bindkey '^[[C'    forward-char
bindkey '^[[D'    backward-char
bindkey '^?'      backward-delete-char
bindkey "^[[3~"   delete-char
bindkey "^[3;5~"  delete-char
bindkey '^[[3;5~' delete-word
bindkey '^H'      backward-delete-word


# edit the current command line in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line
bindkey -M menuselect " " accept-and-menu-complete

# zplug
export ZPLUG_LOADFILE="$HOME/dots/zplug.zsh"
export ZPLUG_BIN="$HOME/.local/zplug/bin"
[[ -d $ZPLUG_BIN ]] || mkdir -p $ZPLUG_BIN
export ZPLUG_REPOS="$HOME/.local/zplug/repos"
[[ -d $ZPLUG_REPOS ]] || mkdir -p $ZPLUG_REPOS
export ZPLUG_CACHE_DIR="$HOME/.cache/zplug"
[[ -d $ZPLUG_CACHE_DIR ]] || mkdir -p $ZPLUG_CACHE_DIR
export ZPLUG_HOME=/usr/local/opt/zplug
source "$ZPLUG_HOME/init.zsh"
# install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
# load plugins
zplug load 


# completions
zstyle ':completion:*:processes' command 'NOCOLORS=1 ps -U $USER|sed "/ps/d"'
zstyle ':completion:*:processes' insert-ids menu yes select
zstyle ':completion:*:processes-names' command 'NOCOLORS=1 ps xho command|sed "s/://g"'
zstyle ':completion:*:processes' sort false
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3))numeric)'
zstyle '*' single-ignored show
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' special-dirs true
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*' list-colors ''
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*:*:zcompile:*' ignored-patterns '(*~|*.zwc)'
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin
if [[ "$CLICOLOR" = 1 ]]; then
  zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=36=31"
  zstyle ':completion:*:warnings' format $'%{\e[0;31m%}No matches for:%{\e[0m%} %d'
  zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)*==36=36}:${(s.:.)LS_COLORS}")';
  zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} 'ma=7;33'
else
  zstyle ':completion:*:warnings' format $'No matches for: %d'
fi


# misc zsh options
setopt braceccl             # Brace expansion
setopt interactive_comments # Allow comments even in interactive shells
setopt nohup                # Don't send the HUP signal to running jobs when 
                            # the shell exits 
setopt nobeep               # No beep on error in ZLE
setopt numericglobsort      # Sort the filenames numerically rather than 
                            # lexicographically
setopt nocaseglob           # Make globbing (filename generation) insensitive 
                            # to case
setopt nocheckjobs          # Don't report the status of background and 
                            # suspended jobs before exiting a shell with job 
                            # control
setopt multios              # Write to multiple descriptors.
setopt extendedglob         # Use extended globbing syntax.
unsetopt clobber            # Do not overwrite existing files with > and >>.
                            # Use >! and >>! to bypass.


# history
HISTFILE="$HOME/.zhistory"
HISTSIZE=10000000
SAVEHIST=10000000
LISTMAX=10000000
setopt bang_hist                 # Treat the '!' character specially during 
                                 # expansion
setopt extended_history          # Write the history file in the 
                                 # ":start:elapsed;command" format
setopt inc_append_history        # Write to the history file immediately, 
                                 # not when the shell exits
setopt share_history             # Share history between all sessions
setopt hist_expire_dups_first    # Expire duplicate entries first when trimming 
                                 # history
setopt hist_ignore_dups          # Don't record an entry that was just recorded 
                                 # again
setopt hist_ignore_all_dups      # Delete old recorded entry if new entry is a 
                                 # duplicate
setopt hist_find_no_dups         # Do not display a line previously found
setopt hist_ignore_space         # Don't record an entry starting with a space
setopt hist_save_no_dups         # Don't write duplicate entries in the history 
                                 # file
setopt hist_reduce_blanks        # Remove superfluous blanks before recording 
                                 # entry
setopt hist_verify               # Don't execute immediately upon history 
                                 # expansion
setopt hist_beep                 # Beep when accessing nonexistent history




# browser
if [[ "$OSTYPE" == darwin* ]]; then
    export BROWSER='open'
fi


# editor
export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'
alias edit="$EDITOR"
alias pager="$PAGER"
alias vi="$EDITOR"
alias vim="$EDITOR"
alias svi="sudo $EDITOR"
alias snano="sudo nano"


# utils
alias less='less -R'
alias md='mkdir -p'
alias rd='rmdir'
alias rm='trash'
alias _="sudo"
alias c='lolcat'
alias cls='clear'
alias diff='colordiff -u'
alias dud='du -s *(/)' # show directories size
alias h='head'
alias history='fc -l 1'
alias ip='ifconfig | grep "inet " | grep -Fv 127.0.0.1 | awk '\''{print $2}'\'
alias of='open .'
alias pgrep='pgrep -f'
alias pkill='pkill -9 -f'
alias port='netstat -ntlp tcp' # opening ports
alias tmux='tmux -2'
alias x='exit'
alias zreload='exec zsh'
alias zclean='trash $ZPLUG_BIN $ZPLUG_REPOS $ZPLUG_CACHE_DIR && exec zsh'

[[ -x "$(command which redshift)" ]] && \
alias redshift='killall redshift >/dev/null 2>&1;redshift -t 5800:5100 -l 49:32 -g 0.95 -b .95 >/dev/null 2>&1 &'

# set fuck aliases
if [ -x "$(command which fuck)" ]; then
  alias fuck='eval $(thefuck $(fc -ln -1))'
  alias please='fuck'
fi


# functions

function man() {
  # about 'better man'
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
  # about 'print colors'
  for i in {0..255}; do
    printf "\x1b[38;5;${i}mcolour${i}\n"
  done
}

function catt() {
  # about 'display whatever file is regular file or folder'
  # param '1: target file or dir'
  # example '$ catt ~/.zshrc'
  for i in "$@"; do
    if [ -d "$i" ]; then
      ll "$i"
    else
      cat "$i"
    fi
  done
}

function ips() {
  # about 'display all ip addresses for this host'
  if command -v ifconfig &>/dev/null; then
    ifconfig | awk '/inet /{ gsub(/addr:/, ""); print $2 }'
  elif command -v ip &>/dev/null; then
    ip addr | grep -oP 'inet \K[\d.]+'
  else
    echo "You don't have ifconfig or ip command installed!"
  fi
}

function myip() {
  # about 'displays your ip address, as seen by the Internet'
  list=("http://myip.dnsomatic.com/" "http://checkip.dyndns.com/" "http://checkip.dyndns.org/")
  for url in ${list[*]}; do
    res=$(command curl -s "${url}")
    if [ $? -eq 0 ]; then
      break
    fi
  done
  res=$(echo "$res" | grep -Eo '[0-9\.]+')
  echo -e "Your public IP is: ${echo_bold_green} $res ${echo_normal}"
}

function lsgrep() {
  # about 'search through directory contents with grep'
  ls -l | grep "$*"
}

function quiet() {
  # about 'what *does* this do?'
  $* &>/dev/null &
}

function command_exists() {
  # about 'checks for existence of a command'
  # param '1: command to check'
  # example '$ command_exists ls && echo exists'
  type "$1" &>/dev/null
}

function buf() {
  # about 'back up file with timestamp'
  # param 'filename'
  local filename=$1
  local filetime=$(date +%Y%m%d_%H%M%S)
  cp -a "${filename}" "${filename}_${filetime}"
}

function explain() {
  # about 'explain any bash command via mankier.com manpage API'
  # param '1: Name of the command to explain'
  # example '$ explain                # interactive mode. Type commands to explain in REPL'
  # example '$ explain '"'"'cmd -o | ...'"'"' # one quoted command to explain it.'
  if [ "$#" -eq 0 ]; then
    while read -p "Command: " cmd; do
        curl -Gs "https://www.mankier.com/api/explain/?cols="$(tput cols) --data-urlencode "q=$cmd"
    done
    echo "Bye!"
  elif [ "$#" -eq 1 ]; then
    curl -Gs "https://www.mankier.com/api/explain/?cols="$(tput cols) --data-urlencode "q=$1"
  else
    echo "Usage"
    echo "explain                  interactive mode."
    echo "explain 'cmd -o | ...'   one quoted command to explain it."
  fi
}

function sshlist() {
  # about 'list hosts defined in ssh config'
  awk '$1 ~ /Host$/ {for (i=2; i<=NF; i++) print $i}' ~/.ssh/config
}


# autocompletion
# kubectl
(( ${+commands[kubectl]} )) && source <(command kubectl completion zsh)
# helm
(( ${+commands[helm]} )) && source <(command helm completion zsh)
# minikube
(( ${+commands[minikube]} )) && source <(command minikube completion zsh)


# plugin settings
# djui/alias-tips
export ZSH_PLUGINS_ALIAS_TIPS_TEXT="📌 alias: "
export ZSH_PLUGINS_ALIAS_TIPS_EXCLUDES="_ c"
export ZSH_PLUGINS_ALIAS_TIPS_EXPAND=1

# zsh-users/zsh-history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down


# The last lines
FZF_SHELL=/usr/local/opt/fzf/shell
# fsf auto-completion
[[ -f "$FZF_SHELL/completion.zsh" ]] && \
    source "$FZF_SHELL/completion.zsh" 2> /dev/null
# fzf key bindings
[[ -f "$FZF_SHELL/key-bindings.zsh" ]] && \
    source "$FZF_SHELL/key-bindings.zsh" 2> /dev/null