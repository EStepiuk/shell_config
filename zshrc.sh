# Setup configs dirs
# TODO: move to installer.sh
export SHELL_P_CONFIGS=$HOME/shell_config
export ZSH_P_CONFIGS=$SHELL_P_CONFIGS/zsh

# Aliases
source $SHELL_P_CONFIGS/aliases.sh

# Init starship prompt
eval $(starship init zsh)

# Syntax highlight
source $ZSH_P_CONFIGS/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

# Completion
source $ZSH_P_CONFIGS/completion.zsh

# Initialize the completion system
autoload -Uz compinit

# Cache completion if nothing changed - faster startup time
typeset -i updated_at=$(date +'%j' -r ~/.zcompdump 2>/dev/null || stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)
if [ $(date +'%j') != $updated_at ]; then
  compinit -i
else
  compinit -C -i
fi

# Enhanced form of menu completion called `menu selection'
zmodload -i zsh/complist

# Autosuggestions
source $ZSH_P_CONFIGS/zsh-autosuggestions/zsh-autosuggestions.zsh

# Keybindings
source $ZSH_P_CONFIGS/key-bindings.zsh

# Configure proper less for bat
export BAT_PAGER="less -R"
