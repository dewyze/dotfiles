## .zshrc - Loaded after .zshenv
## Script relies heavily on safepathappend, safepathprepend and safesource from .zshenv

## Environment display setup
autoload -U compinit
compinit

autoload -U colors
colors

autoload -U select-word-style
select-word-style bash

bindkey -e

setopt prompt_subst

# Environment diagnostic data
export LOCALE="en_US.UTF-8"
export LANG="en_US.UTF-8"

platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
   platform='linux'
elif [[ "$unamestr" == 'FreeBSD' ]]; then
   platform='freebsd'
elif [[ "$unamestr" == 'Darwin' ]]; then
   platform='osx'
fi

#Prompt Setup
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=34:cd=34:su=0:sg=0:tw=0:ow=0:"
export GREP_OPTIONS='--color'
export EDITOR=vim
export LESS='XFR'

if [[ "$platform" == "osx" ]]; then
  PROMPT='%{$fg_bold[green]%}%m: %{$fg_bold[magenta]%}[%{$(free)]%} %{$fg_bold[blue]%}%~%{$fg_bold[green]%}$(git_prompt_info)%{$reset_color%} %#
→ '
else
  PROMPT='%{$fg_bold[green]%}%m: %{$fg_bold[magenta]%}%{$fg_bold[blue]%}%~%{$fg_bold[green]%}$(git_prompt_info)%{$reset_color%} %#
→ '
fi

# ZSH Settings (LOCAL)
## The local version of this file
safesource "$HOME/.zshrc.local"

# Alias definitions (CORE)
## Aliases tend to be long and complicated so they exist elsewhere!
safesource "$HOME/.aliases_shared"
safesource "$HOME/.zsh_aliases"
## (LOCAL)
safesource $HOME/.aliases_shared.local
safesource $HOME/.zsh_aliases.local

# Script Directory (CORE)
safepathprepend $HOME/.bin
## Local (LOCAL)
safepathprepend $HOME/.bin.local

#Common Tools

## Load RVM into a shell session *as a function*
safesource $HOME/.rvm/scripts/rvm

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
