#
# User configuration sourced by interactive shells
#

[[ -s ${HOME}/.profile ]] && source ${HOME}/.profile

# my config
[[ -s ${HOME}/dots/zshrc ]] && source ${HOME}/dots/zshrc

# Define zim location
export ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim

# Start zim
[[ -s ${ZIM_HOME}/init.zsh ]] && source ${ZIM_HOME}/init.zsh

