#!/usr/bin/env bash

source $HOME/.profile

## GENERAL OPTIONS ##

# Prevent file overwrite on stdout redirection
# Use `>|` to force redirection to an existing file
set -o noclobber

# Update window size after every command
shopt -s checkwinsize

# Automatically trim long paths in the prompt (requires Bash 4.x)
PROMPT_DIRTRIM=2

# Enable history expansion with space
# E.g. typing !!<space> will replace the !! with your last command
bind Space:magic-space

# Turn on recursive globbing (enables ** to recurse all directories)
shopt -s globstar 2>/dev/null

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

## SMARTER TAB-COMPLETION (Readline bindings) ##

# Perform file completion in a case insensitive fashion
bind "set completion-ignore-case on"

# Treat hyphens and underscores as equivalent
bind "set completion-map-case on"

# Display matches for ambiguous patterns at first tab press
bind "set show-all-if-ambiguous on"

# Immediately add a trailing slash when autocompleting symlinks to directories
bind "set mark-symlinked-directories on"

# Show extra file information when completing, like `ls -F` does
set visible-stats on

# Be more intelligent when autocompleting by also looking at the text after
# the cursor.
set skip-completed-text on

# Allow UTF-8 input and output, instead of showing stuff like $'\0123\0456'
set input-meta on
set output-meta on
set convert-meta off 

## SANE HISTORY DEFAULTS ##

# Append to the history file, don't overwrite it
shopt -s histappend

# Save multi-line commands as one command
shopt -s cmdhist

# Record each line as it gets issued
PROMPT_COMMAND='history -a'

# Huge history. Doesn't appear to slow things down, so why not?
HISTSIZE=500000
HISTFILESIZE=100000

# Avoid duplicate entries
HISTCONTROL="erasedups:ignoreboth"

# Don't record some commands
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"

# Use standard ISO 8601 timestamp
# %F equivalent to %Y-%m-%d
# %T equivalent to %H:%M:%S (24-hours format)
HISTTIMEFORMAT='%F %T '

## BETTER DIRECTORY NAVIGATION ##

# Prepend cd to directory names automatically
shopt -s autocd 2>/dev/null
# Correct spelling errors during tab-completion
shopt -s dirspell 2>/dev/null
# Correct spelling errors in arguments supplied to cd
shopt -s cdspell 2>/dev/null

# This defines where cd looks for targets
# Add the directories you want to have fast access to, separated by colon
# Ex: CDPATH=".:~:~/projects" will look for targets in the current working directory, in home and in the ~/projects folder
CDPATH="."

# This allows you to bookmark your favorite places across the file system
# Define a variable containing a path and you will be able to cd into it regardless of the directory you're in
shopt -s cdable_vars

# editor
export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'

# browser
if [[ "$OSTYPE" == darwin* ]]; then
    export BROWSER='open'
fi

# Aliases

# Editor
alias edit="$EDITOR"
alias pager="$PAGER"
alias snano="sudo nano"
alias svi="sudo $EDITOR"
alias vi="$EDITOR"
alias vim="$EDITOR"

# General
alias l='ls -1A'         # Lists in one column, hidden files.
alias la='ll -A'         # Lists human readable sizes, hidden files.
alias lc='lt -c'         # Lists sorted by date, most recent last, shows change time.
alias lk='ll -Sr'        # Lists sorted by size, largest last.
alias ll='ls -lh'        # Lists human readable sizes.
alias lm='la | "$PAGER"' # Lists human readable sizes, hidden files through pager.
alias lr='ll -R'         # Lists human readable sizes, recursively.
alias lt='ll -tr'        # Lists sorted by date, most recent last.
alias lu='lt -u'         # Lists sorted by date, most recent last, shows access time.
alias lx='ll -XB'        # Lists sorted by extension (GNU only).
alias sl='ls -G'         # I often screw this up.

# Utils
alias diffu="diff --unified"
alias md='mkdir -p'
alias o='open'
alias rd='rmdir'
alias rm='trash'
alias x='exit'
alias breload='exec bash'

up() {
    brew update
    brew upgrade
    brew cleanup
    ls -G -l /usr/local/Homebrew/Library/Homebrew | grep homebrew-cask | awk '{print $9}' | \
    for evil_symlink in $(cat -); do
        trash -v /usr/local/Homebrew/Library/Homebrew/$evil_symlink
    done
    brew doctor
}

# Resource Usage
alias df='df -kh'
alias du='du -kh'

# Use bash-completion, if available
[[ $PS1 && -f /usr/local/etc/profile.d/bash_completion.sh ]] &&
    . /usr/local/etc/profile.d/bash_completion.sh

if [ -f "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh" ]; then
    __GIT_PROMPT_DIR=$(brew --prefix)/opt/bash-git-prompt/share
    GIT_PROMPT_ONLY_IN_REPO=1
    source "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh"
fi

# The last lines
FZF_SHELL=/usr/local/opt/fzf/shell
# fsf auto-completion
[[ -f "$FZF_SHELL/completion.bash" ]] && \
    source "$FZF_SHELL/completion.bash" 2> /dev/null
# fzf key bindings
[[ -f "$FZF_SHELL/key-bindings.bash" ]] && \
    source "$FZF_SHELL/key-bindings.bash" 2> /dev/null