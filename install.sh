#!/bin bash

# Defaults
DEFAULT_SHELL_CONFIG_PATH="$HOME/.shell_config"

# Install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install git
brew install git

# Read path to desired shell_config dir (defaults to ~/.shell_config)
read -r "Shell config installation path [$DEFAULT_SHELL_CONFIG_PATH]: " shell_config_path
shell_config_path=${shell_config_path:-"$DEFAULT_SHELL_CONFIG_PATH"}

# Clone shell_config
git clone --recurse-submodules git@github.com:EStepiuk/shell_config.git "$shell_config_path"

# Install Brewfile
brew bundle install --file="$shell_config_path/Brewfile"

# Setup .zshrc
echo "export SHELL_CONFIG=$shell_config_path" >> ~/.zshrc
# shellcheck disable=SC2016
echo 'source "$SHELL_CONFIG/.zshrc"' >> ~/.zshrc

# Change default Shell to zsh
# Normally all new macs have zsh pre-installed
# TODO: use homebrew zsh instead? (this will need 'which zsh | sudo tee -a /etc/shells')
chsh -s /bin/zsh

# Finish message
echo 'All done :D'
echo 'Re-sign in to apply shell changes.'

# Re-login
read -r "Proceed with re-sign in? (y/n): " yn
case $yn in
[yY])
  echo "Signing out..."
  sudo launchctl bootout user/"$(id -u "$(whoami)")"
  ;;
*)
  echo "Then do it by yourself..."
  ;;
esac
