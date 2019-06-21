#!/bin/bash

DOT_HUB="https://github.com/kulynyak/x-dotfiles.git"
HAMMER_HUB="https://github.com/kulynyak/hammerspoon.git"

set -e

function dropBoxUp2Date() {
  cat <<'EOF' | osascript 2>/dev/null | sed -E '/Up to date/!d'
tell application "System Events"
  tell UI element "Dropbox"
    tell menu bar 2
      tell menu bar item 1
        set dropBoxStatus to help
      end tell
    end tell
  end tell
end tell
EOF
}

# Install Homebrew (if not installed)
if test ! $(which brew); then
  echo "Installing Homebrew for you."
  # Install the correct homebrew for each OS type
  if test "$(uname)" = "Darwin"; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" && echo "Homebrew installed"
  fi
fi

echo $'\nMake sure we’re using the latest Homebrew.'
brew update

echo $'\nUpgrade any already-installed formulae.'
brew upgrade

echo $'\nSave Homebrew’s installed location.'
BREW_PREFIX=$(brew --prefix)

echo $'\nInstall GNU core utilities (those that come with macOS are outdated).'
echo 'Don’t forget to add $(brew --prefix coreutils)/libexec/gnubin to $PATH'
brew install coreutils
ln -sf "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum"

echo $'\nInstall some other useful utilities like sponge.'
brew install moreutils

echo $'\nInstall GNU find, locate, updatedb, and xargs, g-prefixed.'
brew install findutils

echo $'\nInstall git'
brew install git

echo $'\nInstall rsync'
brew install rsync

echo $'\nInstall python for dotbot'
brew install python
sudo easy_install pip
sudo pip install pyyaml
echo $'\nInstall dotbot'
pip install dotbot --user

echo $'\nInstall DropBox'
brew cask install dropbox

echo $'\nThe next command will fire DropBox on your Mac.'
echo $'\nIf you don’t have DropBox installed and synced - script won’t continue.'
echo $'\nPlease authorize DropBox with your account credentials.'
open -a "Dropbox"
echo $'\nWaiting until DropBox sync is complete...'
# TODO fixme
#until [ "=Up to date=" = "=$(dropBoxUp2Date)=" ]; do
#  sleep 1
#done
echo "DropBox is up to date."

function dir_hnd() {
  dot_dir=$1
  sync_dir=$2
  if [ ! -d "$sync_dir" ]; then
    mkdir -p "$sync_dir"
    if [ -d "$dot_dir" ]; then
      cp -R "$dot_dir/." "$sync_dir/"
    fi
  fi
}

function file_hnd() {
  dot_file=$1
  sync_file_dir=$2
  sync_file_name=$3
  sync_file="$2/$3"
  if [ ! -f "$sync_file" ]; then
    if [ ! -d "$sync_file_dir" ]; then
      mkdir -p "$sync_file_dir"
    fi
    if [ -f "$dot_file" ]; then
      cp "$dot_file" "$sync_file"
    else
      touch "$sync_file"
    fi
  fi
}

echo $'\nSetup DropBox sync folders and files.'
export DOTS_BKP="$HOME/Dropbox/sync.dotfiles"
if [ ! -d "$DOTS_BKP" ]; then
  mkdir -p "$DOTS_BKP"
fi
dir_hnd "$HOME/bin" "$DOTS_BKP/bin"
dir_hnd "$HOME/.ssh" "$DOTS_BKP/ssh"
file_hnd "$HOME/.bash_history" "$DOTS_BKP" "bash_history"
file_hnd "$HOME/.zhistory" "$DOTS_BKP" "zhistory"
file_hnd "$HOME/.fasd" "$DOTS_BKP" "fasd"
dir_hnd "$HOME/.kube" "$DOTS_BKP/kube"

echo $'\nClone Dotfiles if does not exists'
if [ ! -d "$HOME/.dotfiles" ]; then
  git clone --separate-git-dir="$HOME/.dotfiles" "$DOT_HUB" tmpdotfiles
  rsync --recursive --verbose --exclude '.git' tmpdotfiles/ "$HOME/"
  sleep 5
  rm -R tmpdotfile
  git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME config --local status.showUntrackedFiles no
fi
echo $'\nYou can dial with your dotfiles via alias dfs*, or just use dit commands:'
echo "git --git-dir=\$HOME/.dotfiles/ --work-tree=\$HOME <command>"

echo $'\nTmux setup'
if [ ! -d "$HOME/dots/tmux" ]; then
  git clone https://github.com/gpakosz/.tmux.git "$HOME/dots/tmux"
fi

echo $'\nHammerspoon setup'
if [ ! -d "$HOME/.hammerspoon" ]; then
  git clone "$HAMMER_HUB" "$HOME/.hammerspoon"
fi



echo $'\nInstall zsh and make it the default shell'
brew install zsh zplug

echo $'\nCheck zsh is your default shell'
if ! grep -q /usr/local/bin/zsh /etc/shells; then
  echo "adding /usr/local/bin/zsh to /etc/shells..."
  echo "/usr/local/bin/zsh" | sudo tee -a /etc/shells
fi
if [ "=$(dscl . -read $HOME UserShell)=" != "=UserShell: /usr/local/bin/zsh=" ]; then
  echo $'\nmake zsh your default shell'
  chsh -s /usr/local/bin/zsh
fi

echo $'\nConfigure links'
export PATH="$PATH:$HOME/Library/Python/2.7/lib/python/site-packages"
dotbot -c $HOME/dots/install.conf.yaml -d $DOTS_BKP

echo $'Insstall neovim vim-plug'
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo $'\nContinue with brew bundle'
brew bundle --file=$HOME/dots/Brewfile

echo $'\nInstall tmuxinator'
source $HOME/.profile
gem install tmuxinator

echo $'\nLuarocks modules'
luarocks install inspect 
luarocks install luasocket 
luarocks install luautf8

echo $'\nDisable Dock icon for Hammerspoon'
defaults write org.hammerspoon.Hammerspoon MJShowDockIconKey -bool FALSE
killall Hammerspoon || true
open -a "Hammerspoon"
osascript -e 'tell application "System Events" to make login item at end with properties {path:"/Applications/Hammerspoon.app", hidden:true}' > /dev/null
echo 'Done! Remember to enable Accessibility for Hammerspoon.'

echo $'\nKarabiner setup'
open /Applications/Karabiner-Elements.app
osascript -e 'tell application "System Events" to make login item at end with properties {path:"/Applications/Karabiner-Elements.app", hidden:true}' > /dev/null

echo $'\nServices'
brew services start redshift

echo $'\nSetup is done, please logout/login to start use your new config.'
