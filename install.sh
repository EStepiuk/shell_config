#!/bin bash

# Defaults
DEFAULT_SHELL_CONFIG_PATH="$HOME/.shell_config"

# Install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"

# Read path to desired shell_config dir (defaults to ~/.shell_config)
read -r -p "Shell config installation path [$DEFAULT_SHELL_CONFIG_PATH]: " shell_config_path
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
if [ ! "$SHELL" = "/bin/zsh" ]; then
  chsh -s /bin/zsh
  need_re_login=true
fi 

echo 'All done :D'

# Re-login not needed, finish
if [ ! $need_re_login = true ]; then
  source_command='source ~/.zshrc'
  echo "Run '$source_command' to apply shell changes. (Command + V)"
  printf "$source_command" | pbcopy
  exit 0
fi

# Re-login prompt
echo "Re-sign in to apply shell changes."
read -r -p "Proceed with re-sign in? (y/n): " yn
case $yn in
[yY])
  echo "Signing out..."
  sudo launchctl bootout user/"$(id -u "$(whoami)")"
  ;;
*)
  echo "Then do it by yourself..."
  ;;
esac
