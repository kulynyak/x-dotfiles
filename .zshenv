#
# Defines environment variables.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ ("$SHLVL" -eq 1 && ! -o LOGIN) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

if [ -f "${HOME}/.profile" ]; then
  source ${HOME}/.profile
fi

# Temporary Files
if [[ ! -d "$TMPDIR" ]]; then
  export TMPDIR=/tmp/$LOGNAME
  mkdir -p -m 700 "$TMPDIR"
fi

export TMPPREFIX=${TMPDIR%/}/zsh

# djui/alias-tips
export ZSH_PLUGINS_ALIAS_TIPS_TEXT='💡 '

export DISPLAY=:0

# Term setup
export TERM='screen-256color'

# fix for tmux on macOS Sierra
export EVENT_NOKQUEUE=1
