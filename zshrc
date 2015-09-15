
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

setopt prompt_subst

export LOCALE="en_US.UTF-8"
export LANG="en_US.UTF-8"

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=34:cd=34:su=0:sg=0:tw=0:ow=0:"
export GREP_OPTIONS='--color'
export EDITOR=vim
export LESS='XFR'

### Aliases

[[ -s "$HOME/.aliases_shared" ]] && . "$HOME/.aliases_shared"
[[ -s "$HOME/.zsh_aliases" ]] && . "$HOME/.zsh_aliases"

# Local Zsh Aliases
# You will probably have system-specific settings. Simply add them
# to ~/.zsh_aliases.local (which is not included with this repository).
if [ -f ~/.zsh_aliases.local ]; then
    . ~/.zsh_aliases.local
fi


PROMPT='%{$fg_bold[green]%}%m: %{$fg_bold[magenta]%}[%{$(free)]%} %{$fg_bold[blue]%}%~%{$fg_bold[green]%}$(git_prompt_info)%{$reset_color%} %#
→ '


[[ -s "$HOME/.bin" ]] && export PATH=$HOME/.bin:$PATH
[[ -s "$HOME/.bin.local/" ]] && export PATH=$HOME/.bin:$PATH

[[ -s "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"

