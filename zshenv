
autoload -U compinit
compinit

autoload -U colors
colors

autoload -U select-word-style
select-word-style bash

bindkey -e

export PATH=/usr/local/bin:$PATH

[[ -s "/usr/local/heroku/bin" ]] && export PATH="/usr/local/heroku/bin:$PATH"

export PATH=/Applications/Postgres.app/Contents/Versions/9.4/bin:$PATH
[[ -s "$HOME/.rvm/bin" ]] && export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

[[ -s "$HOME/dev/go" ]] && export GOPATH=$HOME/dev/go # This is for being able to execute go scripts from anywhere
