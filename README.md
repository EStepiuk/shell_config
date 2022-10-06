# My shell configs

For now only `zsh` is supported, **IMHO:** it's the best one 😁

### Installation

Clone repo:

```shell
git clone git@github.com:EStepiuk/shell_config.git ~/shell_config
```

Install dependencies:

* with `Brewfile` (TODO: how to)
* `.oh-my-zsh` (TODO: add as submodule?)
* TODO

Setup `.zshrc`:

```shell
echo 'export SHELL_CONFIG="$HOME/shell_config"\nsource "$SHELL_CONFIG/.zshrc"' > ~/.zshrc ; source ~/.zshrc
```
