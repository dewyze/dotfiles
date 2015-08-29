source ~/.aliases

autoload -U compinit
compinit

autoload -U colors
colors

autoload -U select-word-style
select-word-style bash

bindkey -e

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

PATH=/usr/local/bin:$PATH
export PATH

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export PATH=/Applications/Postgres.app/Contents/Versions/9.4/bin:$PATH

export GOPATH=$HOME/dev/go
# export PATH=$PATH:$GOPATH/bin  # This is for being able to execute go scripts from anywhere
