# .zshenv - First zsh config script loaded
setopt INTERACTIVE_COMMENTS

# HELPER FUNCTIONS
safepathappend() {
  if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    PATH="${PATH:+"$PATH:"}$1"
  fi
}

safepathprepend() {
  if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    PATH="$1${PATH:+":$PATH"}"
  fi
}

safesource() {
  if [ -s "$1" ]; then
    source $1
  fi
}

export RIPGREP_CONFIG_PATH=~/.config/ripgrep/ripgreprc

# Being extra cautious to get local bin executables in path
safepathprepend "/usr/local/bin"

# safepathprepend $HOME/Library/Python/3.7/bin


## Common Applications
safepathappend /usr/local/heroku/bin
safepathappend ~/Library/Python/3.7/bin
safepathprepend /opt/homebrew/bin
safepathprepend /opt/homebrew/opt
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
safepathprepend ~/.cargo/bin
. "$HOME/.cargo/env"
