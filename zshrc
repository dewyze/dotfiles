## .zshrc - Loaded after .zshenv
## Script relies heavily on safepathappend, safepathprepend and safesource from .zshenv

## Environment display setup
autoload -Uz compinit
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
export EDITOR=vim
export LESS='XFR'
alias grep=grep --color=auto

get_paged_memory() {
  echo $(( $(vm_stat | grep "Pages $1" | awk '{gsub(/\./,"")} {print $NF}') * 4096 / 1024 / 1024 / 1000.0 ))
}

freemem() {
  installed=$(( $(sysctl -n hw.memsize) / 1024 / 1024 / 1000.0 ))
  wired_down=$(get_paged_memory 'wired down')
  active=$(get_paged_memory 'active')
  inactive=$(get_paged_memory 'inactive')

  printf "%.2fG" "$(( installed - wired_down - active - inactive ))"
}

if [[ "$platform" == "osx" ]]; then
  PROMPT='%{$fg_bold[green]%}%m: %{$fg_bold[magenta]%}[%{$(freemem)]%} %{$fg_bold[blue]%}%~%{$fg_bold[green]%}$(git_prompt_info)%{$reset_color%} %#
→ '
else
  PROMPT='%{$fg_bold[green]%}%m: %{$fg_bold[magenta]%}%{$fg_bold[blue]%}%~%{$fg_bold[green]%}$(git_prompt_info)%{$reset_color%} %#
→ '
fi

# ZSH Settings (LOCAL)
setopt INTERACTIVE_COMMENTS

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

# Common Tools

if type "postgres" > /dev/null; then
  safepathappend /Applications/Postgres.app/Contents/Versions/latest/bin
fi

if type hub > /dev/null; then
  alias git=hub
fi

if type nvim > /dev/null; then
  alias vim=nvim
fi

safesource $HOME/.asdf/asdf.sh
safesource $HOME/.fzf.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# This is for ruby 2.7.0 until rails address deprecation warnings
# You can remove in a shell with `unset RUBYOPT`
# export RUBYOPT='-W:no-deprecated -W:no-experimental'
