##my::dotfiles

In the constant quest to make every machine in your image you'll need *nix config files. This repo contains all of the "must have" features in a really easy to install package.

## Install
Simply run `rake` or `rake install` or `rake all:install` from within the repository. Install happens according to `~/` paths. We'll try to keep what's there, but chance are whatever bad decisions you made prior to installing these dotfiles will be forever gone. #yolo

Note: You want to make sure the repository exists in a stable and convenient place. Once installed, the repository cannot be moved or deleted without causing serious instability. Be sure to run a clean uninstall before deleting or moving the configuration.

## How it works

This repository installs a core set of configurations for various essential tools.

For shell configurations, aliases and scripts it also provides the concept of `.local`. This way you can create local content unique to your specific system while offloading the bulk of the work to the core configuration. If you're running on a Raspberry Pi add some Rasbian specific settings in `~/.bashrc.local`. If you've got a script that only works from box with specific credentials toss it in `~/.bin.local`.

Most of the work is done by installing some symbolic links in your `$HOME` folder to each individual configuration file (e.g. `~/.vimrc -> /path/to/repository/vimrc`) or to subdirectories (e.g. `~/.bin/ -> /path/to/repository/bin`). However, some content is pushed straight to physical directories for stability reasons (e.g. vim plugins will download and install content straight into your `~/.vim` directory).

## Shell Config Loading
The configs assume a standard shell invocation process and currently support `bash` and `zsh`. Remember that `zsh` wins in most cases, so just do that? The load paths for each are as follows with what loads each config:

### ZSH
```
  (system) -> .zshenv
  (system) -> .zshrc
    (zshrc) -> .zshrc.local (if you created it)
    (zshrc) -> .aliases_shared
    (zshrc) -> .zsh_aliases
    (zshrc) -> .aliases_shared.local (if you created it)
    (zshrc) -> .zsh_aliases.local (if you created it)
```

### BASH
```
  (system) -> .bashrc
    (bashrc) -> .bashrc.local (if you created it)
    (bashrc) -> .aliases_shared
    (bashrc) -> .bash_aliases
    (bashrc) -> .aliases_shared.local (if you created it)
    (bashrc) -> .bash_aliases.local (if you created it)
```

The shell configs are intended to be used on top of one another without much/any overhead. Our goal was to create a clean environment whether you start in `bash` and `tmux`(`bmuxs`) into `zsh` or go straight into `zsh`.

## Tmuxline
This uses [tmuxline.vim](https://github.com/edkolev/tmuxline.vim). Tmuxline can be used to match against [vim-airline](https://github.com/vim-airline/vim-airline), [powerline](https://github.com/powerline/powerline), [vim-lightline](https://github.com/itchyny/lightline.vim) or any other certain type of status line. Currently this defaults to the style of the normal vim status line, but you can use another status line in your `.vimrc.local` and create a `.tmuxline.conf.local` which will be referenced instead to make a tmux status line that matches a vim one.

## Uninstall

Simply run `rake uninstall` from within the repository. This should also be helpful if installation fails halfway though.

